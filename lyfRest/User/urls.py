
from django.urls import path,include
from rest_framework.authtoken import views as drf
from . import views

urlpatterns = [
    path('signUp/', views.createAccount),
    path('logIn/', views.loginToAccount.as_view()),
    path('<str:userId>/get/',views.get),
    path('<str:userId>/update/',views.updateAccount),
    path('<str:userId>/deactivate/',views.deactivateAccount),
    path('<str:userId>/delete/',views.deleteAccount),
    path('<str:userId>/todos/',include("todo.urls"),),
    path('<str:userId>/diaryEntries/', include("diary.urls"),),
]