import 'package:academic/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:academic/core/theme/const.dart';
import 'package:academic/core/helper/ui_extention.dart';
import 'package:academic/data/api/categories/model/category_model.dart';
import 'package:academic/data/repository/categories_repository.dart';
import 'package:academic/core/helper/image_ur_handler.dart';

class CategoryTreeBottomSheet extends StatefulWidget {
  final CategoryModel? selectedCategory;
  final Function(CategoryModel) onCategorySelected;

  const CategoryTreeBottomSheet({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryTreeBottomSheet> createState() => _CategoryTreeBottomSheetState();
}

class _CategoryTreeBottomSheetState extends State<CategoryTreeBottomSheet> {
  final ICategoriesRepository _categoriesRepository = GetIt.I<ICategoriesRepository>();
  final TextEditingController _searchController = TextEditingController();
  
  List<CategoryNode> _allCategories = [];
  List<CategoryNode> _displayCategories = [];
  Set<int> _expandedCategories = {};
  CategoryModel? _selectedCategory;
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _loadCategories();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      setState(() => _isLoading = true);
      final response = await _categoriesRepository.getCategories(query: '');
      
      // Build tree structure
      final allCats = <CategoryModel>[
        ...response.mainCategories,
        ...(response.subCategories ?? []),
      ];
      
      _allCategories = _buildCategoryTree(allCats);
      _displayCategories = _allCategories;
      
      // Expand selected category's path
      if (_selectedCategory != null) {
        _expandPathToCategory(_selectedCategory!.id);
      }
      
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  List<CategoryNode> _buildCategoryTree(List<CategoryModel> categories) {
    final Map<int, CategoryNode> nodeMap = {};
    final List<CategoryNode> roots = [];

    // Create all nodes - assume all main categories can have children
    for (final category in categories) {
      nodeMap[category.id] = CategoryNode(
        category: category,
        children: [],
        childrenLoaded: false, // We don't know if they have children yet
      );
    }

      // Build tree structure only for categories that have parentId
      // Note: Since API doesn't return subcategories in initial call,
      // we assume all main categories might have children
      for (final category in categories) {
        final node = nodeMap[category.id]!;
        if (category.parentId == null || category.parentId == 0) {
          roots.add(node);
          // Assume main categories can have children (we'll check via API)
        } else {
          final parent = nodeMap[category.parentId];
          if (parent != null) {
            parent.children.add(node);
            parent.childrenLoaded = true; // We know this parent has children
          } else {
            // Parent not found, treat as root
            roots.add(node);
          }
        }
      }

    // Sort by name
    _sortNodes(roots);
    return roots;
  }

  // Find a node in the tree by ID
  CategoryNode? _findNode(int categoryId, List<CategoryNode> nodes) {
    for (final node in nodes) {
      if (node.category.id == categoryId) {
        return node;
      }
      final found = _findNode(categoryId, node.children);
      if (found != null) {
        return found;
      }
    }
    return null;
  }

  // Load subcategories for a specific category
  Future<void> _loadSubCategories(CategoryNode node) async {
    if (node.isLoadingChildren || node.childrenLoaded) {
      return;
    }

    setState(() {
      node.isLoadingChildren = true;
    });

    try {
      final response = await _categoriesRepository.getSubCategories(node.category.id);
      
      // Get all subcategories from response
      final subCats = <CategoryModel>[
        ...response.mainCategories,
        ...(response.subCategories ?? []),
      ];

      // Build child nodes
      final childNodes = subCats.map((cat) => CategoryNode(
        category: cat,
        children: [],
        childrenLoaded: false,
      )).toList();

      // Sort children
      childNodes.sort((a, b) => a.category.name.compareTo(b.category.name));

      setState(() {
        node.children = childNodes;
        node.childrenLoaded = true;
        node.isLoadingChildren = false;
      });
    } catch (e) {
      setState(() {
        node.isLoadingChildren = false;
        // Even on error, mark as loaded to prevent infinite retries
        // If error, assume no children
        node.childrenLoaded = true;
        node.children = [];
      });
    }
  }

  void _sortNodes(List<CategoryNode> nodes) {
    nodes.sort((a, b) => a.category.name.compareTo(b.category.name));
    for (final node in nodes) {
      if (node.children.isNotEmpty) {
        _sortNodes(node.children);
      }
    }
  }

  void _expandPathToCategory(int categoryId) {
    CategoryNode? targetNode;
    
    void findNode(List<CategoryNode> nodes) {
      for (final node in nodes) {
        if (node.category.id == categoryId) {
          targetNode = node;
          return;
        }
        if (node.children.isNotEmpty) {
          findNode(node.children);
          if (targetNode != null) {
            _expandedCategories.add(node.category.id);
            return;
          }
        }
      }
    }
    
    findNode(_allCategories);
    if (targetNode != null) {
      _expandedCategories.add(categoryId);
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _displayCategories = _allCategories;
      } else {
        _displayCategories = _filterCategories(_allCategories, query);
        // Expand all when searching
        _expandedCategories = _getAllCategoryIds(_displayCategories);
      }
    });
  }

  List<CategoryNode> _filterCategories(List<CategoryNode> nodes, String query) {
    final List<CategoryNode> filtered = [];
    
    for (final node in nodes) {
      final matches = node.category.name.toLowerCase().contains(query);
      final filteredChildren = _filterCategories(node.children, query);
      
      if (matches || filteredChildren.isNotEmpty) {
        filtered.add(CategoryNode(
          category: node.category,
          children: filteredChildren,
        ));
      }
    }
    
    return filtered;
  }

  Set<int> _getAllCategoryIds(List<CategoryNode> nodes) {
    final Set<int> ids = {};
    for (final node in nodes) {
      ids.add(node.category.id);
      ids.addAll(_getAllCategoryIds(node.children));
    }
    return ids;
  }

  Future<void> _toggleExpand(int categoryId) async {
    // Find the node
    final node = _findNode(categoryId, _allCategories);
    if (node == null) return;

    if (_expandedCategories.contains(categoryId)) {
      // Collapse
      setState(() {
        _expandedCategories.remove(categoryId);
      });
    } else {
      // Expand - load children if not loaded
      if (!node.childrenLoaded) {
        await _loadSubCategories(node);
      }
      setState(() {
        _expandedCategories.add(categoryId);
      });
    }
  }

  void _selectCategory(CategoryModel category) {
    setState(() {
      _selectedCategory = category;
    });
    widget.onCategorySelected(category);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.onSurfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s20,
              vertical: AppSpacing.s12,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.category_rounded,
                  color: context.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Text(
                    l10n.selectCategory,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  tooltip: l10n.close,
                ),
              ],
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s20),
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.corner12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchCategory,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear_rounded,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s16,
                    vertical: AppSpacing.s12,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: AppSpacing.s16),
          
          // Categories list
          Flexible(
            child: _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.s32),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _displayCategories.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.s32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.category_outlined,
                                size: 64,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: AppSpacing.s16),
                              Text(
                                l10n.noCategoryFound,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.s20,
                        ),
                        itemCount: _displayCategories.length,
                        itemBuilder: (context, index) {
                          return _CategoryTreeItem(
                            node: _displayCategories[index],
                            level: 0,
                            isExpanded: _expandedCategories.contains(
                              _displayCategories[index].category.id,
                            ),
                            isSelected: _selectedCategory?.id ==
                                _displayCategories[index].category.id,
                            expandedCategories: _expandedCategories,
                            selectedCategory: _selectedCategory,
                            onToggleExpand: _toggleExpand,
                            onSelect: _selectCategory,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class CategoryNode {
  final CategoryModel category;
  List<CategoryNode> children;
  bool childrenLoaded;
  bool isLoadingChildren;

  CategoryNode({
    required this.category,
    required this.children,
    this.childrenLoaded = false,
    this.isLoadingChildren = false,
  });
}

class _CategoryTreeItem extends StatelessWidget {
  final CategoryNode node;
  final int level;
  final bool isExpanded;
  final bool isSelected;
  final Set<int> expandedCategories;
  final CategoryModel? selectedCategory;
  final Future<void> Function(int) onToggleExpand;
  final Function(CategoryModel) onSelect;

  const _CategoryTreeItem({
    required this.node,
    required this.level,
    required this.isExpanded,
    required this.isSelected,
    required this.expandedCategories,
    required this.selectedCategory,
    required this.onToggleExpand,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    // Show expand icon if:
    // 1. Children are loaded and there are children, OR
    // 2. Children are not loaded yet (we'll check via API)
    final hasChildren = node.childrenLoaded 
        ? node.children.isNotEmpty 
        : true; // Assume main categories might have children
    final indent = level * 24.0;
    final imageUrl = buildImageUrl(node.category.image);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: indent,
            right: AppSpacing.s16,
            top: 2,
            bottom: 2,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primaryContainer.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.corner12),
            border: isSelected
                ? Border.all(
                    color: context.colorScheme.primary,
                    width: 2,
                  )
                : null,
          ),
          child: Row(
            children: [
              // Expand/Collapse icon - separate tap area
              if (hasChildren)
                GestureDetector(
                  onTap: () => onToggleExpand(node.category.id),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 40,
                    height: 48,
                    alignment: Alignment.center,
                    child: node.isLoadingChildren
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                context.colorScheme.primary,
                              ),
                            ),
                          )
                        : AnimatedRotation(
                            turns: isExpanded ? 0.25 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 24,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                )
              else
                const SizedBox(width: 40),
              
              // Main selectable area
              Expanded(
                child: InkWell(
                  onTap: () => onSelect(node.category),
                  borderRadius: BorderRadius.circular(AppRadius.corner12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s12,
                      vertical: AppSpacing.s12,
                    ),
                    child: Row(
                      children: [
                        // Category icon
                        if (imageUrl != null && imageUrl.isNotEmpty)
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: context.colorScheme.outline.withOpacity(0.2),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(
                                  Icons.category_rounded,
                                  size: 20,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: context.colorScheme.primaryContainer.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.category_rounded,
                              size: 20,
                              color: context.colorScheme.primary,
                            ),
                          ),
                        
                        const SizedBox(width: AppSpacing.s12),
                        
                        // Category name
                        Expanded(
                          child: Text(
                            node.category.name,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? context.colorScheme.primary
                                  : context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        
                        // Selected indicator
                        if (isSelected)
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: AppSpacing.s8),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              size: 16,
                              color: context.colorScheme.onPrimary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Children
        if (hasChildren && isExpanded)
          ...node.children.map(
            (child) => _CategoryTreeItem(
              node: child,
              level: level + 1,
              isExpanded: expandedCategories.contains(child.category.id),
              isSelected: selectedCategory?.id == child.category.id,
              expandedCategories: expandedCategories,
              selectedCategory: selectedCategory,
              onToggleExpand: onToggleExpand,
              onSelect: onSelect,
            ),
          ),
      ],
    );
  }
}
