# terraform-oci
Build OCI with terraform


## 値を入力し環境変数を設定する
```bash
cat <<'EOF'> .env && source .env
export TF_VAR_TENANCY_OCID=" "
export TF_VAR_COMPARTMENT_OCID=" "
export TF_VAR_USER_OCID=" "
export TF_VAR_FINGERPRINT=" "
export TF_VAR_PRIVATE_KEY_INSTANCE_PATH=" "
export TF_VAR_SSH_PUBLIC_KEY_PATH=" "
export TF_VAR_API_KEY_PATH=" "
EOF
```