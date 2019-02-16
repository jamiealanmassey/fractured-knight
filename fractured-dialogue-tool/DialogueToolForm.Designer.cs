namespace fractured_dialogue_tool
{
    partial class DialogueToolForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DialogueToolForm));
            this.Titlebar = new System.Windows.Forms.Panel();
            this.TitlebarIcon = new System.Windows.Forms.PictureBox();
            this.AppLabel = new System.Windows.Forms.Label();
            this.BtnMinimise = new System.Windows.Forms.Button();
            this.BtnMaximise = new System.Windows.Forms.Button();
            this.BtnClose = new System.Windows.Forms.Button();
            this.TitlebarTools = new System.Windows.Forms.Panel();
            this.Statusbar = new System.Windows.Forms.Panel();
            this.ToolContext = new System.Windows.Forms.TableLayoutPanel();
            this.Titlebar.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.TitlebarIcon)).BeginInit();
            this.SuspendLayout();
            // 
            // Titlebar
            // 
            this.Titlebar.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.Titlebar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.Titlebar.Controls.Add(this.TitlebarIcon);
            this.Titlebar.Controls.Add(this.AppLabel);
            this.Titlebar.Controls.Add(this.BtnMinimise);
            this.Titlebar.Controls.Add(this.BtnMaximise);
            this.Titlebar.Controls.Add(this.BtnClose);
            this.Titlebar.Location = new System.Drawing.Point(0, 0);
            this.Titlebar.Name = "Titlebar";
            this.Titlebar.Size = new System.Drawing.Size(800, 31);
            this.Titlebar.TabIndex = 3;
            this.Titlebar.MouseDown += new System.Windows.Forms.MouseEventHandler(this.TitlebarMouseDown);
            this.Titlebar.MouseMove += new System.Windows.Forms.MouseEventHandler(this.TitlebarMouseMove);
            this.Titlebar.MouseUp += new System.Windows.Forms.MouseEventHandler(this.TitlebarMouseUp);
            // 
            // TitlebarIcon
            // 
            this.TitlebarIcon.Image = global::fractured_dialogue_tool.Properties.Resources.fml_ico;
            this.TitlebarIcon.Location = new System.Drawing.Point(8, 4);
            this.TitlebarIcon.Name = "TitlebarIcon";
            this.TitlebarIcon.Size = new System.Drawing.Size(25, 24);
            this.TitlebarIcon.TabIndex = 4;
            this.TitlebarIcon.TabStop = false;
            // 
            // AppLabel
            // 
            this.AppLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.AppLabel.AutoSize = true;
            this.AppLabel.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.AppLabel.Location = new System.Drawing.Point(33, 8);
            this.AppLabel.Name = "AppLabel";
            this.AppLabel.Size = new System.Drawing.Size(140, 15);
            this.AppLabel.TabIndex = 2;
            this.AppLabel.Text = "Fractured Dialogue Tool";
            // 
            // BtnMinimise
            // 
            this.BtnMinimise.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.BtnMinimise.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMinimise.Cursor = System.Windows.Forms.Cursors.Hand;
            this.BtnMinimise.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMinimise.FlatAppearance.BorderSize = 0;
            this.BtnMinimise.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMinimise.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMinimise.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.BtnMinimise.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMinimise.Image = global::fractured_dialogue_tool.Properties.Resources.icons8_minimize_window_48;
            this.BtnMinimise.Location = new System.Drawing.Point(720, 4);
            this.BtnMinimise.Name = "BtnMinimise";
            this.BtnMinimise.Size = new System.Drawing.Size(22, 22);
            this.BtnMinimise.TabIndex = 3;
            this.BtnMinimise.UseVisualStyleBackColor = false;
            this.BtnMinimise.Click += new System.EventHandler(this.BtnMinimiseClick);
            // 
            // BtnMaximise
            // 
            this.BtnMaximise.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.BtnMaximise.Cursor = System.Windows.Forms.Cursors.Hand;
            this.BtnMaximise.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMaximise.FlatAppearance.BorderSize = 0;
            this.BtnMaximise.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMaximise.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMaximise.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.BtnMaximise.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnMaximise.Image = global::fractured_dialogue_tool.Properties.Resources.icons8_maximize_window_48;
            this.BtnMaximise.Location = new System.Drawing.Point(745, 4);
            this.BtnMaximise.Margin = new System.Windows.Forms.Padding(3, 3, 6, 3);
            this.BtnMaximise.Name = "BtnMaximise";
            this.BtnMaximise.Size = new System.Drawing.Size(22, 22);
            this.BtnMaximise.TabIndex = 5;
            this.BtnMaximise.UseVisualStyleBackColor = false;
            this.BtnMaximise.Click += new System.EventHandler(this.BtnMaximiseClick);
            // 
            // BtnClose
            // 
            this.BtnClose.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.BtnClose.Cursor = System.Windows.Forms.Cursors.Hand;
            this.BtnClose.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnClose.FlatAppearance.BorderSize = 0;
            this.BtnClose.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnClose.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.BtnClose.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.BtnClose.Image = ((System.Drawing.Image)(resources.GetObject("BtnClose.Image")));
            this.BtnClose.Location = new System.Drawing.Point(770, 4);
            this.BtnClose.Margin = new System.Windows.Forms.Padding(3, 3, 6, 3);
            this.BtnClose.Name = "BtnClose";
            this.BtnClose.Size = new System.Drawing.Size(22, 22);
            this.BtnClose.TabIndex = 0;
            this.BtnClose.UseVisualStyleBackColor = false;
            this.BtnClose.Click += new System.EventHandler(this.BtnCloseClick);
            // 
            // TitlebarTools
            // 
            this.TitlebarTools.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.TitlebarTools.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.TitlebarTools.Location = new System.Drawing.Point(0, 30);
            this.TitlebarTools.Name = "TitlebarTools";
            this.TitlebarTools.Size = new System.Drawing.Size(800, 30);
            this.TitlebarTools.TabIndex = 5;
            // 
            // Statusbar
            // 
            this.Statusbar.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.Statusbar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.Statusbar.Location = new System.Drawing.Point(0, 460);
            this.Statusbar.Name = "Statusbar";
            this.Statusbar.Size = new System.Drawing.Size(800, 20);
            this.Statusbar.TabIndex = 6;
            // 
            // ToolContext
            // 
            this.ToolContext.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.ToolContext.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.ToolContext.ColumnCount = 2;
            this.ToolContext.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 80F));
            this.ToolContext.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 20F));
            this.ToolContext.Location = new System.Drawing.Point(0, 60);
            this.ToolContext.Name = "ToolContext";
            this.ToolContext.RowCount = 1;
            this.ToolContext.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.ToolContext.Size = new System.Drawing.Size(800, 400);
            this.ToolContext.TabIndex = 7;
            // 
            // DialogueToolForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(20)))), ((int)(((byte)(20)))), ((int)(((byte)(20)))));
            this.ClientSize = new System.Drawing.Size(800, 480);
            this.Controls.Add(this.Titlebar);
            this.Controls.Add(this.TitlebarTools);
            this.Controls.Add(this.ToolContext);
            this.Controls.Add(this.Statusbar);
            this.ForeColor = System.Drawing.SystemColors.Control;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.MinimumSize = new System.Drawing.Size(640, 480);
            this.Name = "DialogueToolForm";
            this.Text = "Fractured Dialogue Tool";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.DialogueToolFormKeyDown);
            this.Titlebar.ResumeLayout(false);
            this.Titlebar.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.TitlebarIcon)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button BtnClose;
        private System.Windows.Forms.Panel Titlebar;
        private System.Windows.Forms.Label AppLabel;
        private System.Windows.Forms.Button BtnMinimise;
        private System.Windows.Forms.PictureBox TitlebarIcon;
        private System.Windows.Forms.Button BtnMaximise;
        private System.Windows.Forms.Panel TitlebarTools;
        private System.Windows.Forms.Panel Statusbar;
        private System.Windows.Forms.TableLayoutPanel ToolContext;
    }
}

