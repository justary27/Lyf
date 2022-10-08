from datetime import datetime
import json
from django.http import FileResponse
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from User.models import LyfUser
from .models import DiaryEntry
from .serializers import DiaryEntrySerializer
from .utils import DiaryGenerator, TxtGenerator

import io


# Create your views here.
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getAllDiaries(request, userId):
    entries = DiaryEntry.objects.getEntries(userId)
    data = [entry.as_dict for entry in entries]
    return Response(data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getAllPDFs(request, userId):
    diary = DiaryEntry.objects.getEntries(userId)

    file_buffer = io.BytesIO()
    file_buffer = DiaryGenerator.generateDiary(diary=diary, file_buffer=file_buffer)
    file_buffer.seek(0)

    return FileResponse(file_buffer, as_attachment=True, filename=f"{diary[0]._user.username}_diary.pdf")


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getAllTXTs(request, userId):
    diary = DiaryEntry.objects.getEntries(userId)

    file_buffer = io.BytesIO()
    file_buffer = TxtGenerator.generateDiaryTxt(diary, file_buffer)
    file_buffer.seek(0)

    return FileResponse(file_buffer, as_attachment=True, filename=f"{diary[0]._user.username}_diary.txt")


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getEntrybyId(request, userId, entryId):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    data = entry.as_dict

    return Response(data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getPDFbyEntryId(request, userId, entryId, entryId2):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    data = entry.as_dict

    file_buffer = io.BytesIO()
    file_buffer = DiaryGenerator.generateEntry(entry=entry, file_buffer=file_buffer)
    file_buffer.seek(0)

    file_buffers = io.BytesIO()
    TxtGenerator.generateEntryTxt(entry, file_buffers)

    return FileResponse(file_buffer, as_attachment=True, filename=f"{data['_title']}.pdf")


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def getTXTbyEntryId(request, userId, entryId, entryId2):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    data = entry.as_dict

    file_buffer = io.BytesIO()
    file_buffer = TxtGenerator.generateEntryTxt(entry, file_buffer)
    file_buffer.seek(0)

    return FileResponse(file_buffer, as_attachment=True, filename=f"{data['_title']}.txt")


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def createEntry(request, userId):
    data = request.data
    print(request.data)

    try:
        entry = DiaryEntry.objects.create(
            _user=LyfUser.objects.get_user_by_id(userId),
            _title=data['_title'],
            _description=data['_description'],
            _is_private=data['_is_private'],
            _created_on=datetime.fromisoformat(data['_createdAt']),
            _audioLink=data['_audioLink'],
            _imageLinks=data['_imageLinks'] if data['_imageLinks'] != "null" else None,
        )

        return Response("E_CREATE_SUCCESS", status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_403_FORBIDDEN)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def updateEntry(request, userId, entryId):
    data = request.data

    corrected_data = {
        '_user': userId,
        '_title': data["_title"],
        '_description': data["_description"],
        '_is_private': data["_is_private"],
        '_created_on': data["_createdAt"],
        '_audioLink': data["_audioLink"],
        '_imageLinks': list(data['_imageLinks'][1:-1].replace(",", "").split(" ")) if data[
                                                                                          '_imageLinks'] != "null" else None,
    }
    print(corrected_data)

    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    serializer = DiaryEntrySerializer(entry, data=corrected_data)
    if serializer.is_valid():
        serializer.save()
        return Response("E_PUT_SUCCESS", status=status.HTTP_200_OK)
    else:
        return Response(serializer.errors, status=status.HTTP_401_UNAUTHORIZED)


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def deleteEntry(request, userId, entryId):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    try:
        entry.delete()
        return Response("E_DEL_SUCCESS", status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status=status.HTTP_401_UNAUTHORIZED)
