.class Lcom/example/mastg_test0016/Profile$1;
.super Ljava/lang/Object;
.source "Profile.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/mastg_test0016/Profile;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/mastg_test0016/Profile;


# direct methods
.method constructor <init>(Lcom/example/mastg_test0016/Profile;)V
    .locals 0

    .line 33
    iput-object p1, p0, Lcom/example/mastg_test0016/Profile$1;->this$0:Lcom/example/mastg_test0016/Profile;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .line 37
    iget-object p1, p0, Lcom/example/mastg_test0016/Profile$1;->this$0:Lcom/example/mastg_test0016/Profile;

    invoke-virtual {p1}, Lcom/example/mastg_test0016/Profile;->clearSession()V

    return-void
.end method
