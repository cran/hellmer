% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hellmer.R
\name{chat_sequential}
\alias{chat_sequential}
\title{Process a batch of prompts in sequence}
\usage{
chat_sequential(
  chat_model = NULL,
  echo = "none",
  max_retries = 3L,
  initial_delay = 20,
  max_delay = 80,
  backoff_factor = 2,
  timeout = 60,
  beep = TRUE,
  ...
)
}
\arguments{
\item{chat_model}{ellmer chat model function or object (e.g., \code{ellmer::chat_claude})}

\item{echo}{Level of output to display: "none" for silent operation,
"text" for response text only, or "all" for full interaction (default: "none")}

\item{max_retries}{Maximum number of retry attempts per prompt (default: 3L)}

\item{initial_delay}{Initial delay in seconds before first retry (default: 20)}

\item{max_delay}{Maximum delay in seconds between retries (default: 80)}

\item{backoff_factor}{Factor to multiply delay by after each retry (default: 2)}

\item{timeout}{Maximum time in seconds to wait for each prompt response (default: 60)}

\item{beep}{Logical to play a sound on batch completion, interruption, and error (default: TRUE)}

\item{...}{Additional arguments passed to the underlying chat model (e.g., \code{system_prompt})}
}
\value{
A batch object (S7 class) containing
\itemize{
\item prompts: Original input prompts
\item responses: Raw response data for completed prompts
\item completed: Number of successfully processed prompts
\item state_path: Path where batch state is saved
\item type_spec: Type specification used for structured data
\item texts: Function to extract text responses (includes structured data when a type specification is provided)
\item chats: Function to extract chat objects
\item progress: Function to get processing status
}
}
\description{
Processes a batch of chat prompts one at a time in sequential order.
Maintains state between runs and can resume interrupted processing.
For parallel processing, use \code{chat_future()}.
}
\examples{
\dontshow{if (ellmer::has_credentials("openai")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
# Create a sequential chat processor
chat <- chat_sequential(chat_openai, system_prompt = "Reply concisely, one sentence")

# Process a batch of prompts in sequence
batch <- chat$batch(list(
  "What is R?",
  "Explain base R versus tidyverse",
  "Explain vectors, lists, and data frames"
))

# Check the progress if interrupted
batch$progress()

# Return the responses
batch$texts()

# Return the chat objects
batch$chats()
\dontshow{\}) # examplesIf}
}
