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

from .models import DiaryEntry

class EntryPDFGenerator:
    def __init__(self, fontData: dict,):
        self.fontData = fontData
        self.registerFont()


    def textFormatter(self, text:str): 
        text = text.replace(' ','&nbsp;')
        text = text.replace('\n','<br />')
        text = text.replace('\t','&nbsp;&nbsp;&nbsp;&nbsp')
        return text

    def registerFont(self):

        for font in list(self.fontData.keys()):
            fontFile = self.fontData.get(font)
            rl_config.TTFSearchPath.append(str(settings.BASE_DIR) + "/static/fonts")
            newFont = TTFont(font, fontFile)
            pdfmetrics.registerFont(newFont)

    def generateEntry(self, entry:DiaryEntry, file_buffer: io.BytesIO):

        self.entry = entry
        self.fileBuffer = file_buffer
        self.canva = canvas.Canvas(self.fileBuffer,pagesize=A4)
        self.canva.setCreator("Lyf")

        parts = []
        
        title = self.textFormatter(self.entry.asDict['_title'])
        lineBreak = "&nbsp;&nbsp;<br />"
        description = self.textFormatter(self.entry.asDict['_description'])

        titleStyle = ParagraphStyle(
            name="Title",
            fontName="Ubuntu",
            fontSize=20,
        )
        descriptionStyle = ParagraphStyle(
            name='Description',
            fontName='ABZee',
            fontSize=10,
        )

        parts.append(Paragraph(title, style = titleStyle))
        parts.append(Paragraph(lineBreak, style=titleStyle))
        parts.append(Paragraph(lineBreak, style=titleStyle))
        parts.append(Paragraph(description, style = descriptionStyle))
        summaryName = SimpleDocTemplate(
            self.fileBuffer, 
            title=self.entry.asDict['_title'], 
            creator="Lyf", 
            author=entry._user.username, 
            subject=entry._user.username+"'s "+self.entry.asDict['_title']
            )
        summaryName.build(parts)

        # self.canva.setTitle(self.entry.asDict['_title'])

        return self.fileBuffer

fontData = {
    "ABZee": "ABeeZee-Regular.ttf",
    "Ubuntu": "Ubuntu-Regular.ttf",
}

DiaryGenerator = EntryPDFGenerator(fontData=fontData)