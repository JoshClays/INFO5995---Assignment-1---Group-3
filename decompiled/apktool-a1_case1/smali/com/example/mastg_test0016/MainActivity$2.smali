.class Lcom/example/mastg_test0016/MainActivity$2;
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


# direct methods
.method constructor <init>(Lcom/example/mastg_test0016/MainActivity;)V
    .locals 0

    .line 48
    iput-object p1, p0, Lcom/example/mastg_test0016/MainActivity$2;->this$0:Lcom/example/mastg_test0016/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    .line 51
    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/example/mastg_test0016/MainActivity$2;->this$0:Lcom/example/mastg_test0016/MainActivity;

    const-class v1, Lcom/example/mastg_test0016/Login;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 52
    iget-object v0, p0, Lcom/example/mastg_test0016/MainActivity$2;->this$0:Lcom/example/mastg_test0016/MainActivity;

    invoke-virtual {v0, p1}, Lcom/example/mastg_test0016/MainActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method
