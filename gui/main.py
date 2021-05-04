from kivy.app import *
from kivy.uix.recycleview import RecycleView
from kivy.lang import Builder

Builder.load_string('''
<ExampleRV>:
    viewclass: 'Button'
    RecycleBoxLayout:
        size_hint_y: None
        height: self.minimum_height
        orientation: 'vertical'
''')


class Rv(RecycleView):
    def __init__(self, **kwargs):
        super(Rv, self).__init__(**kwargs)
        self.data = [{'text': str(x)} for x in range(20)]


class Gui(App):
    def build(self):
        return Rv()


if __name__ == '__main__':
    Gui().run()
