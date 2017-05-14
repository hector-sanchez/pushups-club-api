class ClubsController < ApplicationController
	before_action :set_club, only: [:show, :update, :destroy]

	def index
		@clubs = Club.all
		json_response(@clubs)
	end

	def create
		@club = Club.create!(club_params)
		json_response(@club, :created)
	end

	def show
		json_response(@club)
	end

	def update
		@club.update(club_params)
		head :no_content
	end

	def destroy
		@club.destroy
		head :no_content
	end

	private

		def club_params
			params.permit(:name, :created_by)
		end

		def set_club
			@club = Club.find(params[:id])
		end
end
