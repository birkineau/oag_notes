IMPORTANT:

- This project (work-in-progress) is set up to use mock API's to showcase the general sign-up/sign-in flow; including error handling, form validation, and animations. It is a fairly standard implementation of authentication processes.

- There is a backend implemented with push notifications, web sockets for real-time comms, and a full email + password authentication module using Firebase.

NOTES:
- All features as listed in the WORKFLOW section have real implementations, but require the server backend to be running. If you would like a demo of the project with the backend active, do not hesitate to ask!

- There is a default 20% mock API failure chance; you can modify this through the `kMockApiFailureChance` constant in `main.dart`.

- Inside `main.dart`, there is a `kUseMockApi` constant that is set to `true`, this is to avoid having to set up the Serverpod part of the project (backend). If you
would like to use the backend, you must set up Serverpod, but this might be non-trivial in time due to various requirements (project configuration setup + auth files, etc.).

WORKFLOW:

1. Sign-in page:
- The user is presented with a generic sign-in page, offering the option to sign-in. The default mock email is `abc.123@example.com` and the password is `a123456!`.
- Below the page title, there is a button to open the sign-up page.
- Below the sign-in form, there is a button to recover a user's password.

2. Sign-up page:
- The user should enter a valid e-mail address.
- The password requires at least one letter, at least one number, and at least one special character.
- The password confirmation must match the password.
- Password visibility can be toggled for either password field.
- When the user creates their account, they will be redirected to the account validation (OTP 6-digit) page. When using the real backend, the code is sent to the e-mail and expires after 5 minutes.
- The user can return to the sign-in page by tapping the button below the page title.

3. Account validation page:
- The mock validation code is `123456`.
- The resend button can be used when running the real server to resend a new code; this removes the previous code (if any).
- The user can return to the sign-in page at any time through the back arrow on the right of the page title. When running the real server, if the user attempts to sign-in without validating their account, they are redirected to the account validation page (this page).
- Upon a successful validation, a success message and image is shown. Additionally, the e-mail field of the sign-in page is auto-filled with the sign-up e-mail.

4. Recovery page:
- The user is first presented with a field (auto-filled with the sign-in e-mail credential) to request the password recovery update.
- In the real server, the server generates a new 6-digit OTP for the user to use, and once sent to the user's e-mail, the client redirects the user to the next step.
- The user must then input a new password, confirm the new password (rules from sign-up apply), and enter the 6-digit code.
- Upon a successful password update, the user is redirected to the sign-in page.
