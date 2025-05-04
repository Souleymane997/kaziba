import { serve } from 'https://deno.land/std/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js'

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get('https://sytctosudzrfupimevdd.supabase.co')!,
    Deno.env.get('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5dGN0b3N1ZHpyZnVwaW1ldmRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYyODM3NDIsImV4cCI6MjA2MTg1OTc0Mn0.fqUfIgu-GS3B6zZ9wvQJi-lEjEKavaLVLQW53fKvuo4')!
  )


  const externalResponse = await fetch('https://api.example.com/sahel-terror')
  const data = await externalResponse.json()


  for (const item of data.articles) {
    await supabase.from('incidents_externes').insert({
      titre: item.title,
      resume: item.description,
      url: item.url,
      source: 'example.com',
      date: new Date(item.publishedAt)
    })
  }

  return new Response(JSON.stringify({ status: 'ok', count: data.articles.length }), {
    headers: { 'Content-Type': 'application/json' },
  })
})
