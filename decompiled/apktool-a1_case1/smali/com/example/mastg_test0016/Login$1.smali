.class Lcom/example/mastg_test0016/Login$1;
.super Ljava/lang/Object;
.source "Login.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/mastg_test0016/Login;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/mastg_test0016/Login;

.field final synthetic val$text1:Landroid/widget/EditText;

.field final synthetic val$text2:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/example/mastg_test0016/Login;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 49
    iput-object p1, p0, Lcom/example/mastg_test0016/Login$1;->this$0:Lcom/example/mastg_test0016/Login;

    iput-object p2, p0, Lcom/example/mastg_test0016/Login$1;->val$text1:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/example/mastg_test0016/Login$1;->val$text2:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 52
    iget-object p1, p0, Lcom/example/mastg_test0016/Login$1;->val$text1:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    .line 53
    iget-object v0, p0, Lcom/example/mastg_test0016/Login$1;->val$text2:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    .line 55
    iget-object v1, p0, Lcom/example/mastg_test0016/Login$1;->this$0:Lcom/example/mastg_test0016/Login;

    invoke-static {v1, p1, v0}, Lcom/example/mastg_test0016/Login;->access$000(Lcom/example/mastg_test0016/Login;Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    .line 56
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "result func:"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p1, :cond_0

    .line 58
    iget-object p1, p0, Lcom/example/mastg_test0016/Login$1;->this$0:Lcom/example/mastg_test0016/Login;

    const-string v0, "Wrong Credential"

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    goto :goto_0

    .line 61
    :cond_0
    iget-object p1, p0, Lcom/example/mastg_test0016/Login$1;->this$0:Lcom/example/mastg_test0016/Login;

    invoke-virtual {p1}, Lcom/example/mastg_test0016/Login;->createSession()V

    .line 62
    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/example/mastg_test0016/Login$1;->this$0:Lcom/example/mastg_test0016/Login;

    const-class v1, Lcom/example/mastg_test0016/Profile;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 63
    iget-object v0, p0, Lcom/example/mastg_test0016/Login$1;->this$0:Lcom/example/mastg_test0016/Login;

    invoke-virtual {v0, p1}, Lcom/example/mastg_test0016/Login;->startActivity(Landroid/content/Intent;)V

    :goto_0
    return-void
.end method
