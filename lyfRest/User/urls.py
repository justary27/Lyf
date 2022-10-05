from django.urls import path, include
from . import views

urlpatterns = [
    path('get/', views.get),
    path('update/', views.updateAccount),
    path('deactivate/', views.deactivateAccount),
    path('delete/', views.deleteAccount),
    path('todo/', include("todo.urls"), ),
    path('diary/', include("diary.urls"), ),
]
