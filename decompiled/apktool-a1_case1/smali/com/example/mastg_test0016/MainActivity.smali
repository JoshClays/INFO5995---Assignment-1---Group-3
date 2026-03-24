.class public Lcom/example/mastg_test0016/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/example/mastg_test0016/MainActivity;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 18
    invoke-direct {p0, p1, p2}, Lcom/example/mastg_test0016/MainActivity;->saveCredentialsToFile(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private saveCredentialsToFile(Ljava/lang/String;Ljava/lang/String;)V
    .locals 5

    const-string v0, "Username: "

    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    const-string v3, "credentials.txt"

    const v4, 0x8000

    .line 60
    invoke-virtual {p0, v3, v4}, Lcom/example/mastg_test0016/MainActivity;->openFileOutput(Ljava/lang/String;I)Ljava/io/FileOutputStream;

    move-result-object v2

    .line 61
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " Password: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "\n"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 62
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-virtual {v2, p1}, Ljava/io/FileOutputStream;->write([B)V

    const-string p1, "Credentials saved to file"

    .line 63
    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v2, :cond_0

    .line 70
    :try_start_1
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_1

    :catch_0
    move-exception p1

    .line 65
    :try_start_2
    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    const-string p1, "Error saving credentials"

    .line 66
    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    if-eqz v2, :cond_0

    .line 70
    :try_start_3
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    goto :goto_0

    :catch_1
    move-exception p1

    .line 72
    invoke-virtual {p1}, Ljava/io/IOException;->printStackTrace()V

    :cond_0
    :goto_0
    return-void

    :goto_1
    if-eqz v2, :cond_1

    .line 70
    :try_start_4
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_2

    :catch_2
    move-exception p2

    .line 72
    invoke-virtual {p2}, Ljava/io/IOException;->printStackTrace()V

    .line 75
    :cond_1
    :goto_2
    throw p1
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 27
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 28
    sget p1, Lcom/example/mastg_test0016/R$layout;->activity_main:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/MainActivity;->setContentView(I)V

    .line 29
    sget p1, Lcom/example/mastg_test0016/R$id;->editTextText:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    .line 30
    sget v0, Lcom/example/mastg_test0016/R$id;->editTextTextPassword:I

    invoke-virtual {p0, v0}, Lcom/example/mastg_test0016/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    .line 31
    sget v1, Lcom/example/mastg_test0016/R$id;->button:I

    invoke-virtual {p0, v1}, Lcom/example/mastg_test0016/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    .line 32
    sget v2, Lcom/example/mastg_test0016/R$id;->lg:I

    invoke-virtual {p0, v2}, Lcom/example/mastg_test0016/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/Button;

    .line 33
    new-instance v3, Lcom/example/mastg_test0016/MainActivity$1;

    invoke-direct {v3, p0, p1, v0}, Lcom/example/mastg_test0016/MainActivity$1;-><init>(Lcom/example/mastg_test0016/MainActivity;Landroid/widget/EditText;Landroid/widget/EditText;)V

    invoke-virtual {v1, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 48
    new-instance p1, Lcom/example/mastg_test0016/MainActivity$2;

    invoke-direct {p1, p0}, Lcom/example/mastg_test0016/MainActivity$2;-><init>(Lcom/example/mastg_test0016/MainActivity;)V

    invoke-virtual {v2, p1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public randomNumberGenerator()I
    .locals 3

    .line 20
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    const/16 v1, 0x64

    .line 21
    invoke-virtual {v0, v1}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    .line 22
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, ""

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Random Number: "

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return v0
.end method
