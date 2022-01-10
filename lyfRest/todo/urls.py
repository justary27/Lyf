from django.urls import path
from . import views

urlpatterns = [
    path('',views.getAllTodos),
    path('create/', views.createTodo),
    path('<str:todoId>/', views.getTodobyId),    
    path('<str:todoId>/update/', views.updateTodo),
    path('<str:todoId>/delete/', views.deleteTodo),
]