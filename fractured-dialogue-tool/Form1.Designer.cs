namespace fractured_dialogue_tool
{
    partial class Form1
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.titlebar = new System.Windows.Forms.Panel();
            this.titlebarIcon = new System.Windows.Forms.PictureBox();
            this.appLabel = new System.Windows.Forms.Label();
            this.btnMinimise = new System.Windows.Forms.Button();
            this.btnMaximise = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.toolContainer = new System.Windows.Forms.SplitContainer();
            this.panel1 = new System.Windows.Forms.Panel();
            this.titlebar.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.titlebarIcon)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.toolContainer)).BeginInit();
            this.toolContainer.SuspendLayout();
            this.SuspendLayout();
            // 
            // titlebar
            // 
            this.titlebar.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.titlebar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.titlebar.Controls.Add(this.titlebarIcon);
            this.titlebar.Controls.Add(this.appLabel);
            this.titlebar.Controls.Add(this.btnMinimise);
            this.titlebar.Controls.Add(this.btnMaximise);
            this.titlebar.Controls.Add(this.btnClose);
            this.titlebar.Location = new System.Drawing.Point(0, 0);
            this.titlebar.Name = "titlebar";
            this.titlebar.Size = new System.Drawing.Size(800, 31);
            this.titlebar.TabIndex = 3;
            this.titlebar.MouseDown += new System.Windows.Forms.MouseEventHandler(this.titlebar_MouseDown);
            this.titlebar.MouseMove += new System.Windows.Forms.MouseEventHandler(this.titlebar_MouseMove);
            this.titlebar.MouseUp += new System.Windows.Forms.MouseEventHandler(this.titlebar_MouseUp);
            // 
            // titlebarIcon
            // 
            this.titlebarIcon.Image = global::fractured_dialogue_tool.Properties.Resources.fml_ico;
            this.titlebarIcon.Location = new System.Drawing.Point(8, 4);
            this.titlebarIcon.Name = "titlebarIcon";
            this.titlebarIcon.Size = new System.Drawing.Size(25, 24);
            this.titlebarIcon.TabIndex = 4;
            this.titlebarIcon.TabStop = false;
            // 
            // appLabel
            // 
            this.appLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.appLabel.AutoSize = true;
            this.appLabel.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.appLabel.Location = new System.Drawing.Point(33, 8);
            this.appLabel.Name = "appLabel";
            this.appLabel.Size = new System.Drawing.Size(140, 15);
            this.appLabel.TabIndex = 2;
            this.appLabel.Text = "Fractured Dialogue Tool";
            // 
            // btnMinimise
            // 
            this.btnMinimise.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnMinimise.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMinimise.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnMinimise.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMinimise.FlatAppearance.BorderSize = 0;
            this.btnMinimise.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMinimise.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMinimise.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnMinimise.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMinimise.Image = global::fractured_dialogue_tool.Properties.Resources.icons8_minimize_window_48;
            this.btnMinimise.Location = new System.Drawing.Point(720, 4);
            this.btnMinimise.Name = "btnMinimise";
            this.btnMinimise.Size = new System.Drawing.Size(22, 22);
            this.btnMinimise.TabIndex = 3;
            this.btnMinimise.UseVisualStyleBackColor = false;
            this.btnMinimise.Click += new System.EventHandler(this.btnMinimiseClick);
            // 
            // btnMaximise
            // 
            this.btnMaximise.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnMaximise.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnMaximise.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMaximise.FlatAppearance.BorderSize = 0;
            this.btnMaximise.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMaximise.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMaximise.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnMaximise.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnMaximise.Image = global::fractured_dialogue_tool.Properties.Resources.icons8_maximize_window_48;
            this.btnMaximise.Location = new System.Drawing.Point(745, 4);
            this.btnMaximise.Margin = new System.Windows.Forms.Padding(3, 3, 6, 3);
            this.btnMaximise.Name = "btnMaximise";
            this.btnMaximise.Size = new System.Drawing.Size(22, 22);
            this.btnMaximise.TabIndex = 5;
            this.btnMaximise.UseVisualStyleBackColor = false;
            this.btnMaximise.Click += new System.EventHandler(this.btnMaximiseClick);
            // 
            // btnClose
            // 
            this.btnClose.Anchor = System.Windows.Forms.AnchorStyles.Right;
            this.btnClose.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnClose.FlatAppearance.BorderColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnClose.FlatAppearance.BorderSize = 0;
            this.btnClose.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnClose.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.btnClose.Image = ((System.Drawing.Image)(resources.GetObject("btnClose.Image")));
            this.btnClose.Location = new System.Drawing.Point(770, 4);
            this.btnClose.Margin = new System.Windows.Forms.Padding(3, 3, 6, 3);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(22, 22);
            this.btnClose.TabIndex = 0;
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.btnCloseClick);
            // 
            // toolContainer
            // 
            this.toolContainer.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.toolContainer.Location = new System.Drawing.Point(12, 68);
            this.toolContainer.Name = "toolContainer";
            // 
            // toolContainer.Panel1
            // 
            this.toolContainer.Panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(128)))));
            // 
            // toolContainer.Panel2
            // 
            this.toolContainer.Panel2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(255)))));
            this.toolContainer.Size = new System.Drawing.Size(776, 400);
            this.toolContainer.SplitterDistance = 597;
            this.toolContainer.TabIndex = 4;
            // 
            // panel1
            // 
            this.panel1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.panel1.Location = new System.Drawing.Point(0, 35);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(800, 27);
            this.panel1.TabIndex = 5;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(20)))), ((int)(((byte)(20)))), ((int)(((byte)(20)))));
            this.ClientSize = new System.Drawing.Size(800, 480);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.titlebar);
            this.Controls.Add(this.toolContainer);
            this.ForeColor = System.Drawing.SystemColors.Control;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.MinimumSize = new System.Drawing.Size(640, 480);
            this.Name = "Form1";
            this.Text = "Fractured Dialogue Tool";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Form1_KeyDown);
            this.titlebar.ResumeLayout(false);
            this.titlebar.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.titlebarIcon)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.toolContainer)).EndInit();
            this.toolContainer.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Panel titlebar;
        private System.Windows.Forms.Label appLabel;
        private System.Windows.Forms.Button btnMinimise;
        private System.Windows.Forms.SplitContainer toolContainer;
        private System.Windows.Forms.PictureBox titlebarIcon;
        private System.Windows.Forms.Button btnMaximise;
        private System.Windows.Forms.Panel panel1;
    }
}

