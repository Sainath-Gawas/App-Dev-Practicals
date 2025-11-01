package com.example.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.google.firebase.FirebaseException;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthOptions;
import com.google.firebase.auth.PhoneAuthProvider;

import java.util.concurrent.TimeUnit;

public class OtpVerificationActivity extends AppCompatActivity {

    private EditText phoneEt, otpEt;
    private Button actionBtn;
    private TextView infoTv;

    private FirebaseAuth mAuth;
    private String verificationId;
    private boolean otpSent = false; // flag to track current step

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_otp_verification);

        // Initialize Firebase
        mAuth = FirebaseAuth.getInstance();

        // Bind views
        phoneEt = findViewById(R.id.phoneEt);
        otpEt = findViewById(R.id.otpEt);
        actionBtn = findViewById(R.id.actionBtn);
        infoTv = findViewById(R.id.infoTv);

        // Set button click listener
        actionBtn.setOnClickListener(v -> {
            if (!otpSent) {
                // Step 1: Send OTP
                String phone = phoneEt.getText().toString().trim();
                if (phone.isEmpty() || phone.length() != 10) {
                    Toast.makeText(this, "Enter a valid 10-digit number", Toast.LENGTH_SHORT).show();
                    return;
                }
                sendVerificationCode("+91" + phone);
            } else {
                // Step 2: Verify OTP
                String otp = otpEt.getText().toString().trim();
                if (otp.isEmpty() || otp.length() < 6) {
                    Toast.makeText(this, "Enter valid 6-digit OTP", Toast.LENGTH_SHORT).show();
                    return;
                }
                verifyCode(otp);
            }
        });
    }

    private void sendVerificationCode(String phoneNumber) {
        infoTv.setText("Sending OTP to " + phoneNumber + "...");
        PhoneAuthOptions options =
                PhoneAuthOptions.newBuilder(mAuth)
                        .setPhoneNumber(phoneNumber)
                        .setTimeout(60L, TimeUnit.SECONDS)
                        .setActivity(this)
                        .setCallbacks(new PhoneAuthProvider.OnVerificationStateChangedCallbacks() {
                            @Override
                            public void onVerificationCompleted(@NonNull PhoneAuthCredential credential) {
                                // Auto-retrieval or instant verification
                                signInWithCredential(credential);
                            }

                            @Override
                            public void onVerificationFailed(@NonNull FirebaseException e) {
                                Toast.makeText(OtpVerificationActivity.this, "Verification failed: " + e.getMessage(), Toast.LENGTH_LONG).show();
                                infoTv.setText("Verification failed. Try again.");
                            }

                            @Override
                            public void onCodeSent(@NonNull String s, @NonNull PhoneAuthProvider.ForceResendingToken token) {
                                super.onCodeSent(s, token);
                                verificationId = s;
                                otpSent = true;
                                otpEt.setVisibility(View.VISIBLE);
                                actionBtn.setText("Verify OTP");
                                infoTv.setText("OTP sent successfully! Please enter the code.");
                                Toast.makeText(OtpVerificationActivity.this, "OTP sent successfully!", Toast.LENGTH_SHORT).show();
                            }
                        })
                        .build();

        PhoneAuthProvider.verifyPhoneNumber(options);
    }

    private void verifyCode(String code) {
        if (verificationId == null) {
            Toast.makeText(this, "Please request OTP again", Toast.LENGTH_SHORT).show();
            return;
        }
        PhoneAuthCredential credential = PhoneAuthProvider.getCredential(verificationId, code);
        signInWithCredential(credential);
    }

    private void signInWithCredential(PhoneAuthCredential credential) {
        mAuth.signInWithCredential(credential)
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful()) {
                        Toast.makeText(this, "Login Successful ✅", Toast.LENGTH_SHORT).show();
                        Intent intent = new Intent(OtpVerificationActivity.this, DashboardActivity.class);
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
                        startActivity(intent);
                        finish();
                    } else {
                        Toast.makeText(this, "Invalid OTP ❌", Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
