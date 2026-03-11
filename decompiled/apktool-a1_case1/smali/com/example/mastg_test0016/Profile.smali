.class public Lcom/example/mastg_test0016/Profile;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "Profile.java"


# static fields
.field private static final KEY_SESSION_TOKEN:Ljava/lang/String; = "sessionToken"

.field private static final SESSION_PREF_NAME:Ljava/lang/String; = "SessionPrefs"


# instance fields
.field private editor:Landroid/content/SharedPreferences$Editor;

.field private sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method static synthetic lambda$onCreate$0(Landroid/view/View;Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/view/WindowInsetsCompat;
    .locals 4

    .line 26
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/core/view/WindowInsetsCompat;->getInsets(I)Landroidx/core/graphics/Insets;

    move-result-object v0

    .line 27
    iget v1, v0, Landroidx/core/graphics/Insets;->left:I

    iget v2, v0, Landroidx/core/graphics/Insets;->top:I

    iget v3, v0, Landroidx/core/graphics/Insets;->right:I

    iget v0, v0, Landroidx/core/graphics/Insets;->bottom:I

    invoke-virtual {p0, v1, v2, v3, v0}, Landroid/view/View;->setPadding(IIII)V

    return-object p1
.end method


# virtual methods
.method public clearSession()V
    .locals 2

    .line 42
    iget-object v0, p0, Lcom/example/mastg_test0016/Profile;->editor:Landroid/content/SharedPreferences$Editor;

    const-string v1, "sessionToken"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 43
    iget-object v0, p0, Lcom/example/mastg_test0016/Profile;->editor:Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 22
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 23
    invoke-static {p0}, Landroidx/activity/EdgeToEdge;->enable(Landroidx/activity/ComponentActivity;)V

    .line 24
    sget p1, Lcom/example/mastg_test0016/R$layout;->activity_profile:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Profile;->setContentView(I)V

    .line 25
    sget p1, Lcom/example/mastg_test0016/R$id;->main:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Profile;->findViewById(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/example/mastg_test0016/Profile$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/example/mastg_test0016/Profile$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {p1, v0}, Landroidx/core/view/ViewCompat;->setOnApplyWindowInsetsListener(Landroid/view/View;Landroidx/core/view/OnApplyWindowInsetsListener;)V

    const-string p1, "SessionPrefs"

    const/4 v0, 0x0

    .line 30
    invoke-virtual {p0, p1, v0}, Lcom/example/mastg_test0016/Profile;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/example/mastg_test0016/Profile;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 31
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    iput-object p1, p0, Lcom/example/mastg_test0016/Profile;->editor:Landroid/content/SharedPreferences$Editor;

    .line 32
    sget p1, Lcom/example/mastg_test0016/R$id;->button3:I

    invoke-virtual {p0, p1}, Lcom/example/mastg_test0016/Profile;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    .line 33
    new-instance v0, Lcom/example/mastg_test0016/Profile$1;

    invoke-direct {v0, p0}, Lcom/example/mastg_test0016/Profile$1;-><init>(Lcom/example/mastg_test0016/Profile;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method
