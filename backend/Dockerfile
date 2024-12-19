# ビルドステージ：AlpineベースJDK
FROM eclipse-temurin:21-jdk-alpine as builder
WORKDIR /app
COPY backend/pom.xml .
RUN apk add --no-cache maven && mvn dependency:go-offline

COPY backend/src ./src
RUN mvn clean package -DskipTests=false

# ランタイムステージ：AlpineベースJRE(またはDistroless)
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
