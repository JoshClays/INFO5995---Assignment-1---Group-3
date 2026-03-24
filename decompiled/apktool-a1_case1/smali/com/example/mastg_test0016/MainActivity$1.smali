.class Lcom/example/mastg_test0016/MainActivity$1;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/mastg_test0016/MainActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/mastg_test0016/MainActivity;

.field final synthetic val$text1:Landroid/widget/EditText;

.field final synthetic val$text2:Landroid/widget/EditText;


# direct methods
.method constructor <init>(Lcom/example/mastg_test0016/MainActivity;Landroid/widget/EditText;Landroid/widget/EditText;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 33
    iput-object p1, p0, Lcom/example/mastg_test0016/MainActivity$1;->this$0:Lcom/example/mastg_test0016/MainActivity;

    iput-object p2, p0, Lcom/example/mastg_test0016/MainActivity$1;->val$text1:Landroid/widget/EditText;

    iput-object p3, p0, Lcom/example/mastg_test0016/MainActivity$1;->val$text2:Landroid/widget/EditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    .line 36
    iget-object p1, p0, Lcom/example/mastg_test0016/MainActivity$1;->val$text1:Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    .line 37
    iget-object v0, p0, Lcom/example/mastg_test0016/MainActivity$1;->val$text2:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, ""

    .line 38
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 43
    :cond_0
    iget-object v1, p0, Lcom/example/mastg_test0016/MainActivity$1;->this$0:Lcom/example/mastg_test0016/MainActivity;

    invoke-static {v1, p1, v0}, Lcom/example/mastg_test0016/MainActivity;->access$000(Lcom/example/mastg_test0016/MainActivity;Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/example/mastg_test0016/MainActivity$1;->this$0:Lcom/example/mastg_test0016/MainActivity;

    const-class v1, Lcom/example/mastg_test0016/Login;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 45
    iget-object v0, p0, Lcom/example/mastg_test0016/MainActivity$1;->this$0:Lcom/example/mastg_test0016/MainActivity;

    invoke-virtual {v0, p1}, Lcom/example/mastg_test0016/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void

    .line 40
    :cond_1
    :goto_0
    iget-object p1, p0, Lcom/example/mastg_test0016/MainActivity$1;->this$0:Lcom/example/mastg_test0016/MainActivity;

    const-string v0, "Fill the Form"

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    return-void
.end method
