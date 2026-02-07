# Data Model

## Core Entities

### User
*   **Purpose:** Identity & trust.
*   **Attributes:** ID, Name, Trust Score, Connections.

### Map
*   **Purpose:** Container of meaning.
*   **Relationships:** Created by User. Contains Pins and Routes.
*   **Notes:** Not just a geo-region, but a curated collection.

### Pin
*   **Purpose:** Moment / place / knowledge.
*   **Attributes:** Location, Title, Description, Media, Timestamp, Visibility.
*   **Relationships:** Belongs to a Map (and potentially a Route/Journey).
*   **Types:** Memory, Safety, Landmark, Route Pin.

### Route (Journey)
*   **Purpose:** Movement & distance.
*   **Attributes:** Path (LatLng list), Duration, Distance, Start/End Time.
*   **Relationships:** Belongs to a Map. Auto-generates Route Pins.

### Troupe
*   **Purpose:** Time & order.
*   **Relationships:** Organizes Pins by day.
*   **Notes:** Likely a temporal grouping of Pins within a Journey/Map.

### Media
*   **Purpose:** Memory.
*   **Types:** Photos, Voice Memos, Text.
*   **Relationships:** Owned by Pin.

### Permission & Trust
*   **Purpose:** Control & Safety.
*   **Levels:** Private, Trusted, Public.

## Database Schema (Current Implementation)

### Pins Table
*   `id` (Int, Auto-inc)
*   `title` (Text)
*   `description` (Text)
*   `latitude` (Real)
*   `longitude` (Real)
*   `createdAt` (DateTime)
*   `isSynced` (Bool)
*   `visibility` (Int: 0=Private, 1=Trusted, 2=Public)
*   `type` (Int: 0=Memory, 1=Safety, 2=Landmark)

### Journeys Table
*   `id` (Int, Auto-inc)
*   `name` (Text)
*   `startTime` (DateTime)
*   `endTime` (DateTime)
*   `routeData` (Text - JSON LatLng)
*   `totalDistance` (Real)
*   `durationSeconds` (Int)
*   `isSynced` (Bool)
*   `visibility` (Int)

## Missing/Planned Schema Elements
*   **Map Entity:** Need a table or mechanism to group Pins/Journeys into "Maps".
*   **Troupe Entity:** Definition needed (Virtual grouping vs Table).
*   **Media Support:** Need table or column for media paths/references linked to Pins.
*   **Foreign Keys:** Link Pins/Journeys to Maps.
