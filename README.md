# terraform-oci-rke
Build rke cluster with terraform on oci

## Always Free 
This terraform builds with Always Free only.

## terraform ディレクトリへ移動
```
cd terraform/
```
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
export TF_VAR_MY_GLOBAL_IP=" "
EOF
```

## 初期化
```bash
terraform init
```

## 定義内容・変更内容の確認
```bash
terraform plan
```

## planの内容を実行
```bash
terraform apply
```