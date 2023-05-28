using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
// using BlazorBootstrap;
using CurriculumVitae;

internal class Program
{
    private static async Task Main(string[] args)
    {
        var builder = WebAssemblyHostBuilder.CreateDefault(args);
        builder.RootComponents.Add<App>("#app");
        builder.RootComponents.Add<HeadOutlet>("head::after");

        // builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri(builder.HostEnvironment.BaseAddress) });
        builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("http://localhost:8123") });
        // builder.Services.AddBlazorBootstrap(); // Add this line

        await builder.Build().RunAsync();
    }
}