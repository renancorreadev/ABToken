// @generated automatically by Diesel CLI.

diesel::table! {
    kyc_entries (id) {
        id -> Int4,
        user_email -> Text,
        identity_hash -> Text,
        status -> Text,
        created_at -> Nullable<Timestamp>,
        updated_at -> Nullable<Timestamp>,
    }
}

diesel::table! {
    kyc_users (id) {
        id -> Int4,
        #[max_length = 255]
        email -> Varchar,
        identity_hash -> Text,
        approved -> Nullable<Bool>,
        created_at -> Nullable<Timestamp>,
    }
}

diesel::allow_tables_to_appear_in_same_query!(kyc_entries, kyc_users,);
