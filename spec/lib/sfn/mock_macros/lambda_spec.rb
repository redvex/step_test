# frozen_string_literal: true

require 'spec_helper'

describe 'Sfn::MockMacros::Lambda' do
  describe '.response' do
    context 'data is an hash' do
      context 'status is 200' do
        let(:data) do
          {
            status: 200,
            payload: 'some response'
          }
        end
        let(:expected_response) do
          {
            '0' => {
              Return: {
                Payload: 'some response',
                StatusCode: 200
              }
            }
          }
        end

        it { expect(Sfn::MockMacros::Lambda.response(data)).to eq(expected_response) }
      end

      context 'status is not 200' do
        let(:data) do
          {
            error: '401',
            cause: 'User not authorised'
          }
        end
        let(:expected_response) do
          {
            '0' => {
              Throw: {
                Error: '401',
                Cause: 'User not authorised'
              }
            }
          }
        end

        it { expect(Sfn::MockMacros::Lambda.response(data)).to eq(expected_response) }
      end
    end

    context 'data is an array of hashes' do
      let(:data) do
        [
          {
            error: '401',
            cause: 'User not authorised'
          },
          {
            status: 200,
            payload: 'some response'
          }
        ]
      end
      let(:expected_response) do
        {
          '0' => {
            Throw: {
              Error: '401',
              Cause: 'User not authorised'
            }
          },
          '1' => {
            Return: {
              Payload: 'some response',
              StatusCode: 200
            }
          }
        }
      end

      it { expect(Sfn::MockMacros::Lambda.response(data)).to eq(expected_response) }
    end
  end
end
