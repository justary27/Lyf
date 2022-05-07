from datetime import datetime
from django.http import FileResponse
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from User.models import LyfUser
from .models import DiaryEntry
from .serializers import DiaryEntrySerializer
from .utils import DiaryGenerator

import io
# Create your views here.
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getAllDiaries(request,userId):
    entries = DiaryEntry.objects.getEntries(userId)
    data = [entry.asDict for entry in entries]
    return Response(data)

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getAllPDFs(request,userId):
    entries = DiaryEntry.objects.getEntries(userId)
    data = [entry.asDict for entry in entries]

    return Response(data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getEntrybyId(request, userId, entryId):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    data = entry.asDict

    return Response(data)

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getPDFbyEntryId(request,userId, entryId, entryId2):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    data = entry.asDict

    file_buffer = io.BytesIO()
    file_buffer = DiaryGenerator.generateEntry(entry=entry, file_buffer=file_buffer)
    file_buffer.seek(0)

    return FileResponse(file_buffer,as_attachment=True,filename=f"{data['_title']}.pdf")
    
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def createEntry(request, userId):
    data = request.data
    print(data["_imageLinks"])

    try:
        entry = DiaryEntry.objects.create(
                _user = LyfUser.objects.get_user_by_id(data['_userId']),
                _title = data['_title'],
                _description = data['_description'],
                _created_on = datetime.fromisoformat(data['_created_on']),
                _audioLink = data['_audioLink'],
                _imageLinks = list(data['_imageLinks'][1:-1]) if data['_imageLinks'] != "Null" else "None",
                )
            
        return Response("Entry Created!" ,status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status= status.HTTP_403_FORBIDDEN)

@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def updateEntry(request, userId, entryId):
    data = request.data
    print(data["_imageLinks"])
    corrected_data = {
        '_user':data["_userId"],
        '_title':data["_title"],
        '_description':data["_description"],
        '_created_on': data['_created_on'],
        '_audioLink':data["_audioLink"],
        '_imageLinks':data["_imageLinks"].split(" "),
    }
    print(corrected_data)

    entry = DiaryEntry.objects.get_entry_by_id(entryId)    
    serializer = DiaryEntrySerializer(entry, data = corrected_data)
    if serializer.is_valid():
        serializer.save()
        return Response("Entry Updated!", status=status.HTTP_200_OK)
    else:
        return Response(serializer.errors, status = status.HTTP_401_UNAUTHORIZED)

@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def deleteEntry(request, userId, entryId):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)    
    try:
        entry.delete()
        return Response("DiaryEntry deleted successfully!", status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e),status=status.HTTP_401_UNAUTHORIZED)
