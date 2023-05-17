require 'swagger_helper'

RSpec.describe 'api/blogs', type: :request do
  
  path '/blogs/' do
    get 'List all published blogs' do
      tags 'Admin', 'Normal User'
      produces 'application/json'
      parameter name: :search, in: :query, type: :string, description: 'Search term of filtering blogs'
      parameter name: :page, in: :query, type: :integer, description: 'Page number of pagination', minimum: 1

      response '200', 'Returns a list of published blogs' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  title: { type: :string },
                  content: { type: :string },
                  # Include other properties as needed
                },
                required: %w[id title content]
              }
            },
            meta: {
              type: :object,
              properties: {
                current_page: { type: :integer },
                total_pages: { type: :integer },
                total_count: { type: :integer },
                # Include other pagination metadata as needed
              },
              required: %w[current_page total_pages total_count]
            }
          },
          required: %w[data meta]

        before do
          # Create sample blogs
          create_list(:blog, 5, published: true, archived: false)
        end

        run_test! do
          expect(response).to have_http_status(200)
          # Additional assertions as needed
        end
      end

      response '404', 'Page Overflow Error' do
        before do
          allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::OverflowError)
        end

        run_test! do
          expect(response).to have_http_status(404)
        end
      end

      response '400', 'Invalid Page Number' do
        before do
          allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::InvalidPage.new('Invalid page number'))
        end

        run_test! do
          expect(response).to have_http_status(400)
        end
      end
    end

    # -----------------------------------------------------------------------------

    post 'Create a new blog' do
      tags 'Admin'
      consumes 'application/json'
      parameter name: :blog_params, in: :body, schema: {
        type: :object,
        properties: {
          blog: {
            type: :object,
            properties: {
              title: { type: :string },
              content: { type: :string },
              archived: { type: :boolean },
              published_at: { type: :string, format: 'date-time' }
            },
            required: %w[title content]
          }
        },
        required: %w[blog]
      }

      response '201', 'Blog created successfully' do
        let(:blog_params) do
          {
            blog: {
              title: 'string',
              content: 'string',
              archived: true,
              published_at: '2023-05-17T07:17:00.292Z'
            }
          }
        end

        run_test! do
          expect(response).to have_http_status(201)
          # Additional assertions as needed
        end
      end

      # Comment the block below i.f you want to handle the c.ase where the blog creation fails
      response '422', 'Blog creation failed' do
        let(:blog_params) do
          {
            blog: {
              title: '',
              content: '',
              archived: false,
              published_at: '2023-05-17T12:00:00Z'
            }
          }
        end
      
        run_test! do
          expect(response).to have_http_status(422)
        end
      end
    end

  end



    # -----------------------------------------------------------------------------
    
    path '/blogs/scheduled' do
      get 'List all scheduled blogs' do
        tags 'Admin'
        produces 'application/json'
  
        response '200', 'Returns a list of scheduled blogs' do
          # Schema definition - the response
          schema type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    title: { type: :string },
                    content: { type: :string },
                    # Include other properties as needed
                  },
                  required: %w[id title content]
                }
              },
              meta: {
                type: :object,
                properties: {
                  current_page: { type: :integer },
                  total_pages: { type: :integer },
                  total_count: { type: :integer },
                  # Include other pagination metadata as needed
                },
                required: %w[current_page total_pages total_count]
              }
            },
            required: %w[data meta]
  
          before do
            # Create sample scheduled blogs
            create_list(:blog, 5, scheduled: true)
          end
  
          run_test! do
            expect(response).to have_http_status(200)
            # Additional assertions as needed
          end
        end
  
        response '404', 'Page Overflow Error' do
          before do
            allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::OverflowError)
          end
  
          run_test! do
            expect(response).to have_http_status(404)
          end
        end
  
        response '400', 'Invalid Page Number' do
          before do
            allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::InvalidPage.new('Invalid page number'))
          end
  
          run_test! do
            expect(response).to have_http_status(400)
          end
        end
    end
  end
    
    # -----------------------------------------------------------------------------

    path '/blogs/draft' do
      get 'List all draft blogs' do
        tags 'Admin'
        produces 'application/json'
  
        response '200', 'Returns a list of draft blogs' do
          # Schema definition - the response
          schema type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    title: { type: :string },
                    content: { type: :string },
                    # Include other properties as needed
                  },
                  required: %w[id title content]
                }
              },
              meta: {
                type: :object,
                properties: {
                  current_page: { type: :integer },
                  total_pages: { type: :integer },
                  total_count: { type: :integer },
                  # Include other pagination metadata as needed
                },
                required: %w[current_page total_pages total_count]
              }
            },
            required: %w[data meta]
  
          before do
            # Create sample draft blogs
            create_list(:blog, 5, draft: true)
          end
  
          run_test! do
            expect(response).to have_http_status(200)
            # Additional assertions as needed
          end
        end
  
        response '404', 'Page Overflow Error' do
          before do
            allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::OverflowError)
          end
  
          run_test! do
            expect(response).to have_http_status(404)
          end
        end
  
        response '400', 'Invalid Page Number' do
          before do
            allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::InvalidPage.new('Invalid page number'))
          end
  
          run_test! do
            expect(response).to have_http_status(400)
          end
        end
  
    end
  end

    # -----------------------------------------------------------------------------
  
    path '/blogs/archived' do
      get 'List all archived blogs' do
        tags 'Admin'
        produces 'application/json'
  
        response '200', 'Returns a list of archived blogs' do
          # Schema definition - the response
          schema type: :object,
            properties: {
              data: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    title: { type: :string },
                    content: { type: :string },
                    # Include other properties as needed
                  },
                  required: %w[id title content]
                }
              },
              meta: {
                type: :object,
                properties: {
                  current_page: { type: :integer },
                  total_pages: { type: :integer },
                  total_count: { type: :integer },
                  # Include other pagination metadata as needed
                },
                required: %w[current_page total_pages total_count]
              }
            },
            required: %w[data meta]
  
          before do
            # Create sample archived blogs
            create_list(:blog, 5, archived: true)
          end
  
          run_test! do
            expect(response).to have_http_status(200)
            # Additional assertions as needed
          end
        end
  
        response '404', 'Page Overflow Error' do
          before do
            allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::OverflowError)
          end
  
          run_test! do
            expect(response).to have_http_status(404)
          end
        end
  
        response '400', 'Invalid Page Number' do
          before do
            allow_any_instance_of(Pagy::Frontend).to receive(:pagy_get_vars).and_raise(Pagy::InvalidPage.new('Invalid page number'))
          end
  
          run_test! do
            expect(response).to have_http_status(400)
          end
        end
  
    end
  end



    # -----------------------------------------------------------------------------


  path '/blogs/{id}' do
  
    get 'Show a blog' do
      tags 'Admin', 'Normal User'
      produces 'application/json'
      
      parameter name: :id, in: :path, type: :integer, description: 'Blog ID'
      response '200', 'Returns a blog' do
        # Schema definition - the response
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            content: { type: :string },
            # Include other properties as needed
          },
          required: %w[id title content]

        let(:id) { create(:blog).id }

        run_test! do
          expect(response).to have_http_status(200)
          # Additional assertions as needed
        end
      end
      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    
      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end

    # -----------------------------------------------------------------------------

  # Not working

  put 'Update a blog' do
    tags 'Blogs'
    consumes 'application/json'
    parameter name: :id, in: :path, type: :integer, description: 'Blog ID'
    parameter name: :blog_params, in: :body, schema: {
      type: :object,
      properties: {
        blog: {
          type: :object,
          properties: {
            title: { type: :string },
            content: { type: :string },
            archived: { type: :boolean },
            published_at: { type: :string, format: 'date-time' }
          },
          required: %w[title content]
        }
      },
      required: %w[blog]
    }

    response '202', 'Blog updated successfully' do
      let(:id) { create(:blog).id }
      let(:blog_params) do
        {
          blog: {
            title: 'string',
            content: 'string',
            archived: true,
            published_at: '2023-05-17T07:39:44.029Z'
          }
        }
      end

      run_test! do
        expect(response).to have_http_status(202)
        # Additional assertions as needed
      end
    end

    response '422', 'Blog update failed' do
      let(:id) { create(:blog).id }
      let(:blog_params) do
        {
          blog: {
            title: '',
            content: ''
          }
        }
      end

      run_test! do
        expect(response).to have_http_status(422)
        # Additional assertions as needed
      end
    end
  end

  end

  # -----------------------------------------------------------------------------

  path '/blogs/{id}/archive' do
    parameter name: :id, in: :path, type: :integer, description: 'Blog ID'

    patch 'Archive a blog' do
      tags 'Admin'

      response '202', 'Blog archived successfully' do
        let(:id) { create(:blog).id }

        run_test! do
          expect(response).to have_http_status(202)
          # Additional assertions as needed
        end
      end

      response '422', 'Blog archive failed' do
        let(:id) { create(:blog).id }

        # Comment the block below i.f you don't want to handle the ca.se where the blog archive fails
        before do
          allow(BlogArchiveJob).to receive(:perform_async).and_return(nil)
        end

        run_test! do
          expect(response).to have_http_status(422)
          # Additional assertions as needed
        end
      end
    end
  end
  # -----------------------------------------------------------------------------








end
