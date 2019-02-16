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
    public partial class Form1 : Form
    {
        private bool isDragging = false;
        private Point relative = Point.Empty;
        private int padding = 10;
        private const int
            HTLEFT = 10,
            HTRIGHT = 11,
            HTTOP = 12,
            HTTOPLEFT = 13,
            HTTOPRIGHT = 14,
            HTBOTTOM = 15,
            HTBOTTOMLEFT = 16,
            HTBOTTOMRIGHT = 17;

        public Form1()
        {
            InitializeComponent();
            FormBorderStyle = FormBorderStyle.None;
            DoubleBuffered = true;
            //SetStyle(ControlStyles.ResizeRedraw, true);
        }

        Rectangle Top { get { return new Rectangle(0, 0, ClientSize.Width, padding); } }
        Rectangle Left { get { return new Rectangle(0, 0, padding, ClientSize.Height); } }
        Rectangle Bottom { get { return new Rectangle(0, ClientSize.Height - padding, ClientSize.Width, padding); } }
        Rectangle Right { get { return new Rectangle(ClientSize.Width - padding, 0, padding, ClientSize.Height); } }
        
        Rectangle TopLeft { get { return new Rectangle(0, 0, padding, padding); } }
        Rectangle TopRight { get { return new Rectangle(ClientSize.Width - padding, 0, padding, padding); } }
        Rectangle BottomLeft { get { return new Rectangle(0, ClientSize.Height - padding, padding, padding); } }
        Rectangle BottomRight { get { return new Rectangle(ClientSize.Width - padding, ClientSize.Height - padding, padding, padding); } }
        
        private void btnMinimiseClick(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)
                Close();
        }

        private void btnMaximiseClick(object sender, EventArgs e)
        {
            WindowState = WindowState == FormWindowState.Maximized ? 
                                         FormWindowState.Normal :
                                         maximise();
        }

        private FormWindowState maximise()
        {
            this.FormBorderStyle = FormBorderStyle.Sizable;
            this.WindowState = FormWindowState.Maximized;
            this.MaximumSize = this.Size;
            this.FormBorderStyle = FormBorderStyle.None;
            //this.Location = new Point(0, 0);
            return FormWindowState.Maximized;
        }

        private void btnCloseClick(object sender, EventArgs e)
        {
            Close();
        }

        private void titlebar_MouseDown(object sender, MouseEventArgs e)
        {
            isDragging = true;
            relative = PointToClient(Cursor.Position);
        }

        private void titlebar_MouseUp(object sender, MouseEventArgs e)
        {
            isDragging = false;
            if (WindowState != FormWindowState.Maximized && Cursor.Position.Y < 1)
                maximise();
        }

        private void titlebar_MouseMove(object sender, MouseEventArgs e)
        {
            if (isDragging)
            {
                if (WindowState == FormWindowState.Maximized && Cursor.Position.Y > 2)
                {
                    //var oldSize = this.Size;
                    WindowState = FormWindowState.Normal;
                    Location = new Point(Cursor.Position.X - relative.X, Cursor.Position.Y - relative.Y);
                    /*var diff = oldSize - this.Size;
                    Location = new Point(Location.X + diff.Width, Location.Y);*/
                }
                else
                {
                    //Location = this.PointToClient(Cursor.Position);
                    Location = new Point(Cursor.Position.X - relative.X, Cursor.Position.Y - relative.Y);
                }
            }
        }

        private void Form_Resize(object sender, EventArgs e)
        {
            if (WindowState == FormWindowState.Minimized)
            {
                Hide();
            }
        }

        private void notifyIcon_Click(object sender, EventArgs e)
        {
            Show();
            WindowState = FormWindowState.Normal;
        }

        protected override void WndProc(ref Message m)
        {
            base.WndProc(ref m);

            if (m.Msg == 0x84)
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
    }
}
