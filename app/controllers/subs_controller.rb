class SubsController < ApplicationController
  layout "subscribe"
  before_action :authenticate_user!, except: [:new, :create]

  def new
    if signed_in? && current_user.subbed?
      redirect_to root_path, notice: "You are already subscribed."
    end
  end

  def create
    Stripe.api_key = Rails.application.credentials.stripe_api_key

    plan_id = params[:plan_id]
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]

    customer = if current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)
               else
                Stripe::Customer.create(email: current_user.email, source: token)
              end

    subscription = customer.subscriptions.create(plan: plan.id)

    options = {
      stripe_id: customer.id,
      stripe_subbed_id: subscription.id,
      subbed: true
    }

    options.merge!(
      end_digits: params[:user][:end_digits],
      card_expiry_month: params[:user][:card_expiry_month],
      card_expiry_year: params[:user][:card_expiry_year],
      card_type: params[:user][:card_type]
    ) if params[:user][:end_digits]

    current_user.update(options)

    redirect_to root_path, notice: "You are now subbed"
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subbed_id).delete
    current_user.update(stripe_subbed_id: nil)
    current_user.subbed = false

    redirect_to root_path, notice: "You are no longer subbed as it has been cancelled."
  end
end
