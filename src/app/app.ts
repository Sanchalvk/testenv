import { JsonPipe } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, JsonPipe],
  templateUrl: './app.html',
  styleUrl: './app.css',
  providers: [HttpClientModule],
})
export class App {
  protected title = 'TestEnv';
  private testURL =
    import.meta.env['NG_APP_URL'] || "'https://task.thingsrms.com/v1"; // read from assest/config.json replace->['NG_APP_URL'] 
  data: any = null;
  constructor(private http: HttpClient) {}

  ngOnInit() {
    console.log(this.testURL);
    this.http.get<any>(this.testURL).subscribe((data) => {
      this.data = data;
    });
  }
}
