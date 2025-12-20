# Chapters & Notes API Specification

## Overview
This document specifies the required API endpoints and data structures for the note-taking (فیش‌نویسی) system.

---

## 1. Chapters (سرفصل) API

### 1.1 GET `/api/my-headlines`
**Status:** ✅ Exists  
**Response Structure:**
```json
{
  "data": [
    {
      "id": 1,
      "title": "تحلیل و بررسی کتاب‌های حقوق",
      "description": "مجموعه یادداشت‌ها و تحلیل‌های مرتبط با این حوزه",
      "user_id": 1,
      "user": {
        "id": 1,
        "name": "علی احمدی",
        "avatar": "https://..."
      },
      "notes_count": 5,
      "created_at": "2024-01-15T10:30:00Z",
      "updated_at": "2024-01-20T14:20:00Z"
    }
  ]
}
```

### 1.2 GET `/api/headlines`
**Status:** ✅ Exists  
**Description:** List all public chapters  
**Response:** Same structure as 1.1

### 1.3 POST `/api/store-headlines`
**Status:** ✅ Exists (needs fix)  
**Current Fields:** `title`, `description`, `image`  
**Required Fields:**
- `title` (string, required, min: 3)
- `description` (string, optional)
- `image` (file, optional) - Remove if not needed

**Response:**
```json
{
  "data": {
    "id": 1,
    "title": "...",
    "description": "...",
    "user_id": 1,
    "user": {...},
    "notes_count": 0,
    "created_at": "...",
    "updated_at": "..."
  }
}
```

### 1.4 PUT `/api/headlines/{id}`
**Status:** ❌ Missing  
**Required Fields:**
- `title` (string, required, min: 3)
- `description` (string, optional)

**Response:** Same as 1.3

### 1.5 DELETE `/api/headlines/{id}`
**Status:** ❌ Missing  
**Response:**
```json
{
  "message": "Chapter deleted successfully"
}
```

### 1.6 GET `/api/headlines/{id}`
**Status:** ❌ Missing  
**Description:** Get chapter details with notes  
**Response:**
```json
{
  "data": {
    "id": 1,
    "title": "...",
    "description": "...",
    "user_id": 1,
    "user": {...},
    "notes_count": 3,
    "created_at": "...",
    "updated_at": "...",
    "notes": [
      {
        "id": 1,
        "excerpt": "متن بریده شده از کتاب...",
        "user_note": "تحلیل: این مفهوم نشان می‌دهد...",
        "chapter_id": 1,
        "book_id": 5,
        "book_name": "اخلاق زندگی اجتماعی",
        "book_image": "https://...",
        "author_name": "حضرت آیت الله مهدوی کنی",
        "author_avatar": null,
        "created_at": "2024-01-18T12:00:00Z"
      }
    ]
  }
}
```

---

## 2. Notes (یادداشت) API

### 2.1 POST `/api/add-to-headlines`
**Status:** ⚠️ Wrong fields  
**Current Fields:** `title`, `description`, `image` ❌  
**Required Fields:**
- `headline_id` or `chapter_id` (integer, required) - Chapter ID to add note to
- `excerpt` (string, required) - Selected text from book
- `user_note` (string, optional) - User's analytical note
- `book_id` (integer, required) - Book ID
- `book_name` (string, required) - Book name
- `book_image` (string, required) - Book cover image URL
- `author_name` (string, optional) - Author name
- `author_avatar` (string, optional) - Author avatar URL

**Response:**
```json
{
  "data": {
    "id": 1,
    "excerpt": "...",
    "user_note": "...",
    "chapter_id": 1,
    "book_id": 5,
    "book_name": "...",
    "book_image": "...",
    "author_name": "...",
    "author_avatar": null,
    "created_at": "2024-01-18T12:00:00Z"
  }
}
```

### 2.2 GET `/api/headlines/{id}/notes`
**Status:** ❌ Missing (or include in 1.6)  
**Description:** Get all notes for a chapter  
**Response:**
```json
{
  "data": [
    {
      "id": 1,
      "excerpt": "...",
      "user_note": "...",
      "chapter_id": 1,
      "book_id": 5,
      "book_name": "...",
      "book_image": "...",
      "author_name": "...",
      "author_avatar": null,
      "created_at": "..."
    }
  ]
}
```

### 2.3 PUT `/api/notes/{id}`
**Status:** ❌ Missing  
**Required Fields:**
- `user_note` (string, optional) - Update only user note

**Response:** Same as 2.1

### 2.4 DELETE `/api/notes/{id}`
**Status:** ❌ Missing  
**Response:**
```json
{
  "message": "Note deleted successfully"
}
```

---

## 3. Data Models

### Chapter Model
```json
{
  "id": "integer",
  "title": "string (required, min: 3)",
  "description": "string (optional)",
  "user_id": "integer",
  "user": {
    "id": "integer",
    "name": "string",
    "avatar": "string (nullable)"
  },
  "notes_count": "integer",
  "created_at": "datetime",
  "updated_at": "datetime"
}
```

### Note Model
```json
{
  "id": "integer",
  "excerpt": "string (required) - Selected text from book",
  "user_note": "string (optional) - User's analytical note",
  "chapter_id": "integer (required)",
  "book_id": "integer (required)",
  "book_name": "string (required)",
  "book_image": "string (required) - Full URL",
  "author_name": "string (optional)",
  "author_avatar": "string (optional) - Full URL",
  "created_at": "datetime"
}
```

---

## 4. Summary of Required Changes

### Fix Existing:
1. ✅ `POST /api/store-headlines` - Remove `image` field if not needed
2. ⚠️ `POST /api/add-to-headlines` - **COMPLETELY REWRITE** - Current fields are wrong

### Add New:
1. `PUT /api/headlines/{id}` - Update chapter
2. `DELETE /api/headlines/{id}` - Delete chapter
3. `GET /api/headlines/{id}` - Get chapter with notes
4. `PUT /api/notes/{id}` - Update note
5. `DELETE /api/notes/{id}` - Delete note

---

## 5. Important Notes

- All chapters are **public** (visible to all users)
- `notes_count` should be **auto-calculated** from related notes
- When a note is created/deleted, update the chapter's `notes_count`
- `excerpt` is the **selected text** from the book (not user's note)
- `user_note` is the **analytical note** added by user (optional)
- All image URLs should be **full URLs** (not relative paths)
- Use **ISO 8601** format for dates
