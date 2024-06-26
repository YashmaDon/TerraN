# Збиаємо наш сервер в автомвтичному режимі з допомогою офіційного базового імеджу golang 
FROM golang as builder
# Встановлюємо залежності програми
WORKDIR /src
# Копіюємо конткент робочої директорії в контент білдера 
COPY src .
COPY go.mod .
# Даємо команду на зборку нашого коду з опією кроскомпіляції для різних платформ (фіча го)
RUN CGO_ENABLED=0 go build -o app
# З мотою оптимізації образу видаємо на виході тільки потрібний нам бінарний байл тому наступною командою переключаємось на пустий базовий образ
FROM scratch
# Додаємо директорію з контентом
ADD ./html /html
# Копієюмо бінарний файл що буде результатом збірки
COPY --from=builder /src/app .
# Вказуємо як саме запускати наш сервер
ENTRYPOINT [ "/app" ]
# Вказуємо порт який слухає наш сервер
EXPOSE 8080