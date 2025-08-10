# Updated Mobile Auth API Usage - Bearer Token

## ✅ **Fixed: Now Uses Bearer Token Instead of Request Body**

The mobile auth APIs have been updated to use the Firebase token from the **Authorization header** instead of requiring it in the request body. This is more secure and follows standard authentication patterns.

## 🚀 **New API Usage**

### 1. **Check User Status**
```http
POST /api/mobile/auth/check-status
Authorization: Bearer <firebase_token>
```

**No request body required!**

### 2. **Register Individual User**  
```http
POST /api/mobile/auth/register-individual
Authorization: Bearer <firebase_token>
Content-Type: application/json

{
  "firstName": "John",
  "lastName": "Doe", 
  "email": "john.doe@email.com"
}
```

### 3. **Register Employee User**
```http
POST /api/mobile/auth/register-employee
Authorization: Bearer <firebase_token>
Content-Type: application/json

{
  "firstName": "Jane",
  "lastName": "Smith",
  "email": "jane.smith@company.com"
}
```

users from flutter app enter mobile and validate otp with firebase -> it check user in backend -> we will tell if it is exists or not. if employee is register in database or not -> if not both user or employee -> user add details and register as individual -> if user not exists but employee details is there in database -> user see the prefilled details and click register -> we add employee as a user -> if user exists then directly login.
implement the flutter side.