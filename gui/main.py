from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
import sys


class Gui(QWidget):
    def __init__(self):
        super().__init__()

        #init ui contents
        self.init_ui()

    def init_ui(self):
        #set font
        QToolTip.setFont(QFont('SansSerif', 10))

        #set window title
        self.setWindowTitle('MTS 3D Scanner')

        #maximize window
        self.showMaximized()

        #show window
        self.show()

    def closeEvent(self, event):
        #show message
        reply = QMessageBox.question(self, 'Message', "Are you sure to quit?",
                                     QMessageBox.Yes | QMessageBox.No, QMessageBox.No)

        #handle response
        if reply == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore()


def main():
    app = QApplication(sys.argv)
    gui = Gui()
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
