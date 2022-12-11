from datetime import datetime
import json
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from User.models import LyfUser
from .models import Todo
from .serializers import TodoSerializer
from rest_framework import status


# Create your views here.
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getAllTodos(request, userId):
    try:
        todos = Todo.objects.getTodos(userId)
        data = [todo.as_dict for todo in todos]

        return Response(data)
    except Exception as e:
        return Response(str(e), status=status.HTTP_401_UNAUTHORIZED)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getTodobyId(request, userId, todo_id):
    todo = Todo.objects.get_todo_by_id(todo_id)
    data = todo.as_dict

    return Response(data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def createTodo(request, userId):
    data = request.data

    try:
        entry = Todo.objects.create(
            _user=LyfUser.objects.get_user_by_id(userId),
            _title=data['_title'],
            _description=data['_description'],
            _created_on=datetime.fromisoformat(data['_createdAt'])
        )
        return Response("Entry Created!", status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_401_UNAUTHORIZED)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def updateTodo(request, userId, todoId):
    data = request.data
    print(request.data)

    corrected_data = {
        '_user': userId,
        '_title': data["_title"],
        '_description': data["_description"],
        '_created_on': data["_createdAt"],
        '_isCompleted': data["_isCompleted"],
        '_isReminderSet': data["_isReminderSet"],
        "_reminderAt": data["_reminderAt"]
    }

    print(corrected_data)
    todo = Todo.objects.get_todo_by_id(todoId)
    serializer = TodoSerializer(todo, data=corrected_data)
    if serializer.is_valid():
        serializer.save()
        return Response("Entry Updated!")
    else:
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def deleteTodo(request, userId, todoId):
    todo = Todo.objects.get_todo_by_id(todoId)

    try:
        todo.delete()
        return Response("Todo deleted successfully!")

    except Exception as e:
        return Response(str(e), status=status.HTTP_401_UNAUTHORIZED)
