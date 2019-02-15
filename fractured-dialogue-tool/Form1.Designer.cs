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
            this.btnClose = new System.Windows.Forms.Button();
            this.titlebar = new System.Windows.Forms.Panel();
            this.appLabel = new System.Windows.Forms.Label();
            this.btnMinimise = new System.Windows.Forms.Button();
            this.titlebar.SuspendLayout();
            this.SuspendLayout();
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
            this.btnClose.Image = global::fractured_dialogue_tool.Properties.Resources.icons8_close_window_48;
            this.btnClose.Location = new System.Drawing.Point(772, 4);
            this.btnClose.Margin = new System.Windows.Forms.Padding(3, 3, 6, 3);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(22, 22);
            this.btnClose.TabIndex = 0;
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.btnCloseClick);
            // 
            // titlebar
            // 
            this.titlebar.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.titlebar.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(40)))), ((int)(((byte)(40)))), ((int)(((byte)(40)))));
            this.titlebar.Controls.Add(this.appLabel);
            this.titlebar.Controls.Add(this.btnMinimise);
            this.titlebar.Controls.Add(this.btnClose);
            this.titlebar.Location = new System.Drawing.Point(0, 0);
            this.titlebar.Name = "titlebar";
            this.titlebar.Size = new System.Drawing.Size(800, 31);
            this.titlebar.TabIndex = 3;
            this.titlebar.MouseDown += new System.Windows.Forms.MouseEventHandler(this.titlebar_MouseDown);
            this.titlebar.MouseMove += new System.Windows.Forms.MouseEventHandler(this.titlebar_MouseMove);
            this.titlebar.MouseUp += new System.Windows.Forms.MouseEventHandler(this.titlebar_MouseUp);
            // 
            // appLabel
            // 
            this.appLabel.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left)));
            this.appLabel.AutoSize = true;
            this.appLabel.Font = new System.Drawing.Font("Arial", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.appLabel.Location = new System.Drawing.Point(12, 9);
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
            this.btnMinimise.ForeColor = System.Drawing.SystemColors.MenuHighlight;
            this.btnMinimise.Image = global::fractured_dialogue_tool.Properties.Resources.icons8_minimize_window_48;
            this.btnMinimise.Location = new System.Drawing.Point(744, 4);
            this.btnMinimise.Name = "btnMinimise";
            this.btnMinimise.Size = new System.Drawing.Size(22, 22);
            this.btnMinimise.TabIndex = 3;
            this.btnMinimise.UseVisualStyleBackColor = false;
            this.btnMinimise.Click += new System.EventHandler(this.btnMinimiseClick);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(20)))), ((int)(((byte)(20)))), ((int)(((byte)(20)))));
            this.ClientSize = new System.Drawing.Size(800, 480);
            this.Controls.Add(this.titlebar);
            this.ForeColor = System.Drawing.SystemColors.Control;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.MinimumSize = new System.Drawing.Size(640, 480);
            this.Name = "Form1";
            this.Text = "Fractured Dialogue Tool";
            this.titlebar.ResumeLayout(false);
            this.titlebar.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Panel titlebar;
        private System.Windows.Forms.Label appLabel;
        private System.Windows.Forms.Button btnMinimise;
    }
}

