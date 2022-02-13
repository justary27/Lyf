from datetime import datetime
from django.http import FileResponse
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from User.models import LyfUser
from .models import DiaryEntry
from .serializers import DiaryEntrySerializer

from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.platypus import BaseDocTemplate
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from django.conf import settings
from reportlab import rl_config
from reportlab.lib.styles import ParagraphStyle
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak

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

# @api_view(["GET"])
# @permission_classes([IsAuthenticated])
def getPDFbyEntryId(request,userId, entryId):
    entry = DiaryEntry.objects.get_entry_by_id(entryId)
    data = entry.asDict

    file_buffer = io.BytesIO()
    canva = canvas.Canvas(file_buffer,pagesize=A4)
    rl_config.TTFSearchPath.append(str(settings.BASE_DIR) + '/static/fonts')
    abZee = TTFont('ABZee', 'ABeeZee-Regular.ttf')
    pdfmetrics.registerFont(abZee)
    file_buffer = generatePDF(file_buffer,entry)
    canva.setFont("ABZee",15)
    canva.setCreator("Lyf")
    canva.drawString(100,100, f"{data['_description']}")
    canva.showPage()
    canva.save()
    file_buffer.seek(0)
    # parts = []
    # entryDict = entry.asDict
    # rl_config.TTFSearchPath.append(str(settings.BASE_DIR) + '/static/fonts')
    # abZee = TTFont('ABZee', 'ABeeZee-Regular.ttf')
    # pdfmetrics.registerFont(abZee)
    # abZee = TTFont('Ubuntu', 'Ubuntu-Regular.ttf')
    # pdfmetrics.registerFont(abZee)

    # title = entryDict['_title'].replace(' ','&nbsp;').replace('\n','<br />').replace('\t','&nbsp;&nbsp;&nbsp;&nbsp')

    # description = entryDict['_description'].replace(' ','&nbsp;').replace('\n','<br />').replace('\t','&nbsp;&nbsp;&nbsp;&nbsp')
    #     # entryDict['_description'] = entryDict['_description'].replace('\n','<br />')
    #     # entryDict['_description'] = entryDict['_description']
    #     # parts.append(Paragraph())
    # style = ParagraphStyle(
    #         name='Description',
    #         fontName='ABZee',
    #         fontSize=10,
    #     )
        
    # parts.append(Paragraph(title, style = style))
    # parts.append(Paragraph(description, style = style))
    # summaryName = SimpleDocTemplate("pdf")
    # # summaryName.build(parts, canvasmaker= canva)

    # canva.showPage()
    # canva.save()

    return FileResponse(file_buffer,as_attachment=True,filename=f"{data['_title']}.pdf")

# @api_view(["PUT"])
# def updateEntry(request, userId, entryId):
#     entry = DiaryEntry.objects.get_entry_by_id(entryId)
    
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def createEntry(request, userId):
    data = request.data

    try:
        entry = DiaryEntry.objects.create(
                _user = LyfUser.objects.get_user_by_id(data['_userId']),
                _title = data['_title'],
                _description = data['_description'],
                _created_on = datetime.fromisoformat(data['_created_on'])
            )
        return Response("Entry Created!" ,status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e), status= status.HTTP_403_FORBIDDEN)

@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def updateEntry(request, userId, entryId):
    data = request.data
    entry = DiaryEntry.objects.get_entry_by_id(entryId)    
    serializer = DiaryEntrySerializer(entry, data = data)
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

#reportlab
class EntryPDF:
    def __init__(self,entry:DiaryEntry, fontName:str, fontPath:str, fontFile:str):
        self.entry = entry
        self.fontName:fontName
        self.fontPath = fontPath
        self.fontFile = fontFile

    def textFormatter(text):
        text = text.replace(' ','&nbsp;')
        text = text.replace('\n','<br />')
        text = text.replace('\t','&nbsp;&nbsp;&nbsp;&nbsp')

    def registerFont(self):
        rl_config.TTFSearchPath.append(str(settings.BASE_DIR) + self.fontPath)
        abZee = TTFont(self.fontName, self.fontFile)
        pdfmetrics.registerFont(abZee)

def generatePDF(file_buffer: io.BytesIO, entry:DiaryEntry):
        parts = []
        entryDict = entry.asDict
        rl_config.TTFSearchPath.append(str(settings.BASE_DIR) + '/static/fonts')
        abZee = TTFont('ABZee', 'ABeeZee-Regular.ttf')
        pdfmetrics.registerFont(abZee)
        abZee = TTFont('Ubuntu', 'Ubuntu-Regular.ttf')
        pdfmetrics.registerFont(abZee)

        title = entryDict['_title'].replace(' ','&nbsp;').replace('\n','<br />').replace('\t','&nbsp;&nbsp;&nbsp;&nbsp')

        description = entryDict['_description'].replace(' ','&nbsp;').replace('\n','<br />').replace('\t','&nbsp;&nbsp;&nbsp;&nbsp')
        # entryDict['_description'] = entryDict['_description'].replace('\n','<br />')
        # entryDict['_description'] = entryDict['_description']
        # parts.append(Paragraph())
        style = ParagraphStyle(
            name='Description',
            fontName='ABZee',
            fontSize=10,
        )
        
        parts.append(Paragraph(title, style = style))
        parts.append(Paragraph(description, style = style))
        summaryName = SimpleDocTemplate(file_buffer)
        summaryName.build(parts)
        # file_buffer.close()
        return file_buffer
