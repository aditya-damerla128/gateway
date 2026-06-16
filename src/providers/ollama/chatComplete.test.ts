import {
  OllamaChatCompleteStreamChunkTransform,
  OllamaStreamChunk,
} from './chatComplete';

describe('OllamaChatCompleteStreamChunkTransform', () => {
  it('preserves usage on final streaming chunks', () => {
    const chunk: OllamaStreamChunk = {
      id: 'chatcmpl-test',
      object: 'chat.completion.chunk',
      created: 1710000000,
      model: 'llama3',
      system_fingerprint: 'fp_test',
      choices: [],
      usage: {
        prompt_tokens: 73,
        completion_tokens: 12,
        total_tokens: 85,
      },
    };

    expect(
      OllamaChatCompleteStreamChunkTransform(`data: ${JSON.stringify(chunk)}`)
    ).toBe(
      `data: ${JSON.stringify({
        id: 'chatcmpl-test',
        object: 'chat.completion.chunk',
        created: 1710000000,
        model: 'llama3',
        provider: 'ollama',
        choices: [],
        usage: {
          prompt_tokens: 73,
          completion_tokens: 12,
          total_tokens: 85,
        },
      })}\n\n`
    );
  });
});
