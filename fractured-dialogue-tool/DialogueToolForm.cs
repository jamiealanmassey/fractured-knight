using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace fractured_dialogue_tool
{
    public partial class DialogueToolForm : Form
    {
        private GlobalMouseHandler mouseHandler = new GlobalMouseHandler();
        private bool isDragging = false;
        private bool isDraggingForm = false;

        private Size oldFormSize = Size.Empty;
        private Size newFormSize = Size.Empty;

        private Point relative = Point.Empty;
        private Point oldLocation = Point.Empty;

        private int padding = 5;
        private const int
            HTLEFT = 10,
            HTRIGHT = 11,
            HTTOP = 12,
            HTTOPLEFT = 13,
            HTTOPRIGHT = 14,
            HTBOTTOM = 15,
            HTBOTTOMLEFT = 16,
            HTBOTTOMRIGHT = 17;

        public DialogueToolForm()
        {
            mouseHandler.MouseMoved += new MouseMovedEvent(GlobalMouseMoved);
            mouseHandler.MouseDown += new MouseDownEvent(GlobalMouseDown);
            mouseHandler.MouseUp += new MouseUpEvent(GlobalMouseUp);
            oldFormSize = this.Size;
            newFormSize = this.Size;

            Application.AddMessageFilter(mouseHandler);
            InitializeComponent();
            FormBorderStyle = FormBorderStyle.None;
            DoubleBuffered = true;
            SetStyle(ControlStyles.ResizeRedraw, true);
        }

        private void GlobalMouseMoved()
        {
            if (isDraggingForm)
            {
                Point point = new Point(Math.Max(Cursor.Position.X - oldLocation.X, 0), Math.Max(Cursor.Position.Y - oldLocation.Y, 0));
                newFormSize = new Size(point);
                Size = newFormSize;
                Cursor.Current = Cursors.SizeNWSE;
                this.Refresh();
            }

            if (BottomRight.Contains(PointToClient(Cursor.Position)))
                Cursor.Current = Cursors.SizeNWSE;
        }

        public void GlobalMouseDown()
        {
            var cursor = PointToClient(Cursor.Position);
            if (BottomRight.Contains(cursor))
            {
                isDraggingForm = true;
                oldLocation = this.Location;
                oldFormSize = this.Size;
                newFormSize = this.Size;
            }
        }

        public void GlobalMouseUp()
        {
            Size = newFormSize;
            isDraggingForm = false;
        }

        new Rectangle Top { get { return new Rectangle(0, 0, ClientSize.Width, padding); } }
        new Rectangle Left { get { return new Rectangle(0, 0, padding, ClientSize.Height); } }
        new Rectangle Bottom { get { return new Rectangle(0, ClientSize.Height - padding, ClientSize.Width, padding); } }
        new Rectangle Right { get { return new Rectangle(ClientSize.Width - padding, 0, padding, ClientSize.Height); } }
        
        Rectangle TopLeft { get { return new Rectangle(0, 0, padding, padding); } }
        Rectangle TopRight { get { return new Rectangle(ClientSize.Width - padding, 0, padding, padding); } }
        Rectangle BottomLeft { get { return new Rectangle(0, ClientSize.Height - padding, padding, padding); } }
        Rectangle BottomRight { get { return new Rectangle(ClientSize.Width - padding, ClientSize.Height - padding, padding, padding); } }

        private void Maximise()
        {
            var workingArea = Screen.GetWorkingArea(this);
            this.oldLocation = this.Location;
            this.oldFormSize = this.Size;
            this.MaximumSize = workingArea.Size;
            this.WindowState = FormWindowState.Maximized;
            this.SetBounds(workingArea.X, workingArea.Y, workingArea.Size.Width, workingArea.Size.Height);
        }

        private void Minimise()
        {
            var oldPosition = PointToClient(Cursor.Position);
            this.WindowState = FormWindowState.Normal;
            this.Location = oldLocation;
            var difference = oldPosition.X - Location.X;
            relative = new Point(relative.X - difference, relative.Y);
        }

        private void DialogueToolFormKeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)
                Close();
        }

        private void BtnMinimiseClick(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }

        private void BtnMaximiseClick(object sender, EventArgs e)
        {
            if (WindowState == FormWindowState.Maximized)
                Minimise();
            else
                Maximise();
        }

        private void BtnCloseClick(object sender, EventArgs e)
        {
            Close();
        }

        private void TitlebarMouseDown(object sender, MouseEventArgs e)
        {
            isDragging = true;
            relative = PointToClient(Cursor.Position);
        }

        private void TitlebarMouseMove(object sender, MouseEventArgs e)
        {
            if (isDragging)
            {
                if (WindowState == FormWindowState.Maximized && Cursor.Position.Y > Screen.GetWorkingArea(this).Y)
                    this.Minimise();
                else
                    Location = new Point(Cursor.Position.X - relative.X, Cursor.Position.Y - relative.Y);
            }
        }

        private void TitlebarMouseUp(object sender, MouseEventArgs e)
        {
            isDragging = false;
            if (WindowState != FormWindowState.Maximized && Cursor.Position.Y < Screen.GetWorkingArea(this).Y + 1)
                Maximise();
        }

        /*private void Form_Resize(object sender, EventArgs e)
        {
            if (WindowState == FormWindowState.Minimized)
            {
                Hide();
            }
        }*/

        protected override void WndProc(ref Message m)
        {
            base.WndProc(ref m);

            if (m.Msg == 0x84 || m.Msg == 0x200)
            {
                var cursor = PointToClient(Cursor.Position);

                     if (TopLeft.Contains(cursor)) m.Result = (IntPtr)HTTOPLEFT;
                else if (TopRight.Contains(cursor)) m.Result = (IntPtr)HTTOPRIGHT;
                else if (BottomLeft.Contains(cursor)) m.Result = (IntPtr)HTBOTTOMLEFT;
                else if (BottomRight.Contains(cursor)) m.Result = (IntPtr)HTBOTTOMRIGHT;

                else if (Top.Contains(cursor)) m.Result = (IntPtr)HTTOP;
                else if (Left.Contains(cursor)) m.Result = (IntPtr)HTLEFT;
                else if (Right.Contains(cursor)) m.Result = (IntPtr)HTRIGHT;
                else if (Bottom.Contains(cursor)) m.Result = (IntPtr)HTBOTTOM;
            }
        }

        protected override void OnResizeBegin(EventArgs e)
        {
            SuspendLayout();
            base.OnResizeBegin(e);
        }

        protected override void OnResizeEnd(EventArgs e)
        {
            ResumeLayout();
            base.OnResizeEnd(e);
        }
    }

    public delegate void MouseMovedEvent();
    public delegate void MouseDownEvent();
    public delegate void MouseUpEvent();

    public class GlobalMouseHandler : IMessageFilter
    {
        private const int WM_MOUSEMOVE = 0x0200;
        private const int WM_MOUSEDOWN = 0x0201;
        private const int WM_MOUSEUP = 0x0202;

        public event MouseMovedEvent MouseMoved;
        public event MouseDownEvent MouseDown;
        public event MouseUpEvent MouseUp;

        #region IMessageFilter Members

        public bool PreFilterMessage(ref Message m)
        {
            if (m.Msg == WM_MOUSEMOVE)
                MouseMoved?.Invoke();
            else if (m.Msg == WM_MOUSEDOWN)
                MouseDown?.Invoke();
            else if (m.Msg == WM_MOUSEUP)
                MouseUp?.Invoke();

            return false;
        }

        #endregion
    }
}
