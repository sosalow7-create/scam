#!/bin/bash
echo "🔑 Настройка SSH для GitHub..."
echo ""

# Генерация SSH ключа
ssh-keygen -t ed25519 -C "sosalow7@gmail.com" -f ~/.ssh/id_ed25519 -N ""

echo ""
echo "✅ SSH ключ создан!"
echo ""
echo "📋 Скопируй этот ключ:"
echo "════════════════════════════════════════════════════════"
cat ~/.ssh/id_ed25519.pub
echo "════════════════════════════════════════════════════════"
echo ""
echo "📝 Теперь:"
echo "1. Иди на https://github.com/settings/keys"
echo "2. Нажми 'New SSH key'"
echo "3. Вставь скопированный ключ"
echo "4. Сохрани"
echo ""
echo "Потом выполни:"
echo "  git remote set-url origin git@github.com:sosalow7-create/scam.git"
echo "  git push"
echo ""
