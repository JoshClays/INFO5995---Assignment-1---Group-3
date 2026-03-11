.class public Lcom/example/mastg_test0016/Login;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "Login.java"


# static fields
.field private static final KEY_SESSION_TOKEN:Ljava/lang/String; = "sessionToken"

.field private static final SESSION_PREF_NAME:Ljava/lang/String; = "SessionPrefs"


# instance fields
.field private editor:Landroid/content/SharedPreferences$Editor;

.field private sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/example/mastg_test0016/Login;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0

    .line 26
    invoke-direct {p0, p1, p2}, Lcom/example/mastg_test0016/Login;->checkCredentials(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method private checkCredentials(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 8

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    const-string v2, "credentials.txt"

    .line 73
    invoke-virtual {p0, v2}, Lcom/example/mastg_test0016/Login;->openFileInput(Ljava/lang/String;)Ljava/io/FileInputStream;

    move-result-object v2
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 74
    :try_start_1
    new-instance v3, Ljava/io/InputStreamReader;

    invoke-direct {v3, v2}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 75
    :try_start_2
    new-instance v4, Ljava/io/BufferedReader;

    invoke-direct {v4, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_3

    .line 77
    :cond_0
    :try_start_3
    invoke-virtual {v4}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    const-string v5, " "

    .line 79
    invoke-virtual {v1, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 80
    array-length v5, v1

    const/4 v6, 0x4

    if-ne v5, v6, :cond_0

    aget-object v5, v1, v0

    const-string v6, "Username:"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v5, 0x2

    aget-object v5, v1, v5

    const-string v6, "Password:"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    const/4 v5, 0x1

    .line 81
    aget-object v6, v1, v5

    const/4 v7, 0x3

    .line 82
    aget-object v1, v1, v7

    .line 84
    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v6

    .line 85
    invoke-virtual {v1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v1

    .line 86
    invoke-virtual {p1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-virtual {p2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    if-eqz v1, :cond_0

    .line 96
    :try_start_4
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V

    .line 99
    invoke-virtual {v3}, Ljava/io/InputStreamReader;->close()V

    if-eqz v2, :cond_1

    .line 102
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 105
    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    :cond_1
    :goto_0
    return v5

    .line 96
    :cond_2
    :try_start_5
    invoke-virtual {v4}, Ljava/io/BufferedReader;->close()V

    .line 99
    invoke-virtual {v3}, Ljava/io/InputStreamReader;->close()V

    if-eqz v2, :cond_5

    .line 102
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_5

    goto :goto_4

    :catchall_0
    move-exception p1

    move-object v1, v4

    goto :goto_5

    :catch_1
    move-exception p1

    move-object v1, v4

    goto :goto_1

    :catch_2
    move-exception p1

    goto :goto_1

    :catchall_1
    move-exception p1

    move-object v3, v1

    goto :goto_5

    :catch_3
    move-exception p1

    move-object v3, v1

    goto :goto_1

    :catchall_2
    move-exception p1

    move-object v2, v1

    move-object v3, v2

    goto :goto_5

    :catch_4
    move-exception p1

    move-object v2, v1

    move-object v3, v2

    .line 92
    :goto_1
    :try_start_6
    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    if-eqz v1, :cond_3

    .line 96
    :try_start_7
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    goto :goto_2

    :catch_5
    move-exception p1

    goto :goto_3

    :cond_3
    :goto_2
    if-eqz v3, :cond_4

    .line 99
    invoke-virtual {v3}, Ljava/io/InputStreamReader;->close()V

    :cond_4
    if-eqz v2, :cond_5

    .line 102
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    goto :goto_4

    .line 105
    :goto_3
    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    :cond_5
    :goto_4
    return v0

    :catchall_3
    move-exception p1

    :goto_5
    if-eqz v1, :cond_6

    .line 96
    :try_start_8
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    goto :goto_6

    :catch_6
    move-exception p2

    goto :goto_7

    :cond_6
    :goto_6
    if-eqz v3, :cond_7

    .line 99
    invoke-virtual {v3}, Ljava/io/InputStreamReader;->close()V

    :cond_7
    if-eqz v2, :cond_8

    .line 102
    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_6

    goto :goto_8

    .line 105
    :goto_7
    invoke-virtual {p2}, Ljava/io/IOException;->printStackTrace()V

    .line 107
    :cond_8
    :goto_8
    throw p1
.end method

.method private generateSessionToken()Ljava/lang/String;
    .locals 6

    .line 123
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    .line 132
    new-instance v1, Ljava/lang/StringBuilder;

    const/16 v2, 0x10

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    const/16 v4, 0x3e

    .line 137
    invoke-virtual {v0, v4}, Ljava/util/Random;->nextInt(I)I

    move-result v4

    const-string v5, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

    .line 139
    invoke-virtual {v5, v4}, Ljava/lang/String;->charAt(I)C

    move-result v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 143
    :cond_0
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method static synthetic lambda$onCreate$0(Landroid/view/View;Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/view/WindowInsetsCompat;
    .locals 4

    .line 37
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/core/view/WindowInsetsCompat;->getInsets(I)Landroidx/core/graphics/Insets;

    move-result-object v0

    .line 38
    iget v1, v0, Landroidx/core/graphics/Insets;->left:I

    iget v2, v0, Landroidx/core/graphics/Insets;->top:I

    iget v3, v0, Landroidx/core/graphics/Insets;->right:I

    iget v0, v0, Landroidx/core/graphics/Insets;->bottom:I

    invoke-virtual {p0, v1, v2, v3, v0}, Landroid/view/View;->setPadding(IIII)V

    return-object p1
.end method


# virtual methods
.method public createSession()V
    .locals 3

    .line 112
    invoke-direct {p0}, Lcom/example/mastg_test0016/Login;->generateSessionToken()Ljava/lang/String;

    move-result-object v0

    .line 113
    iget-object v1, p0, Lcom/example/mastg_test0016/Login;->editor:Landroid/content/SharedPreferences$Editor;

    const-string v2, "sessionToken"

    invoke-interface {v1, v2, v0}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 114
    iget-object v0, p0, Lcom/example/mastg_test0016/Login;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public getSessionToken()Ljava/lang/String;
    .locals 3

    .line 118
    iget-object v0, p0, Lcom/example/mastg_test0016/Login;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v1, "sessionToken"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 33
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 34
    invoke-static {p0}, Landroidx/activity/EdgeToEdge;->enable(Landroidx/activity/ComponentActivity;)V

    .line 35
    sget p1, Lcom/example/mastg_test0016/R$layout;->activity_login:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Login;->setContentView(I)V

    .line 36
    sget p1, Lcom/example/mastg_test0016/R$id;->main:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Login;->findViewById(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/example/mastg_test0016/Login$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/example/mastg_test0016/Login$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {p1, v0}, Landroidx/core/view/ViewCompat;->setOnApplyWindowInsetsListener(Landroid/view/View;Landroidx/core/view/OnApplyWindowInsetsListener;)V

    .line 41
    sget p1, Lcom/example/mastg_test0016/R$id;->toolbar2:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Login;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroidx/appcompat/widget/Toolbar;

    .line 42
    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Login;->setSupportActionBar(Landroidx/appcompat/widget/Toolbar;)V

    .line 43
    invoke-virtual {p0}, Lcom/example/mastg_test0016/Login;->getSupportActionBar()Landroidx/appcompat/app/ActionBar;

    move-result-object p1

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Landroidx/appcompat/app/ActionBar;->setDisplayHomeAsUpEnabled(Z)V

    const-string p1, "SessionPrefs"

    const/4 v0, 0x0

    .line 44
    invoke-virtual {p0, p1, v0}, Lcom/example/mastg_test0016/Login;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/example/mastg_test0016/Login;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 45
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    iput-object p1, p0, Lcom/example/mastg_test0016/Login;->editor:Landroid/content/SharedPreferences$Editor;

    .line 46
    sget p1, Lcom/example/mastg_test0016/R$id;->editTextText2:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Login;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    .line 47
    sget v0, Lcom/example/mastg_test0016/R$id;->editTextTextPassword2:I

    invoke-virtual {p0, v0}, Lcom/example/mastg_test0016/Login;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    .line 48
    sget v1, Lcom/example/mastg_test0016/R$id;->button2:I

    invoke-virtual {p0, v1}, Lcom/example/mastg_test0016/Login;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    .line 49
    new-instance v2, Lcom/example/mastg_test0016/Login$1;

    invoke-direct {v2, p0, p1, v0}, Lcom/example/mastg_test0016/Login$1;-><init>(Lcom/example/mastg_test0016/Login;Landroid/widget/EditText;Landroid/widget/EditText;)V

    invoke-virtual {v1, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method
