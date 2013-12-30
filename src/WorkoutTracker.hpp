/*
 * WorkoutTracker.hpp
 *
 *  Created on: Dec 29, 2013
 *      Author: sdowney
 */

#ifndef WORKOUTTRACKER_HPP_
#define WORKOUTTRACKER_HPP_


#include <QObject>

class WorkoutTracker : public QObject {

	Q_OBJECT

	Q_PROPERTY( QVariantList exercises READ getExercises WRITE setExercises NOTIFY exercisesChanged)
	Q_PROPERTY( int duration READ getDuration WRITE setDuration NOTIFY durationChanged)
	Q_PROPERTY( int interval READ getInterval WRITE setInteval NOTIFY intervalChanged)
	Q_PROPERTY( int cooldown READ getCooldown WRITE setCooldown NOTIFY cooldownChanged)

public:
	WorkoutTracker();
	virtual ~WorkoutTracker();

	Q_INVOKABLE void setExercises(QVariantList exercises) const {
		if (m_workout) {
			m_workout.setExercises(exercises);
		} else {
			m_workout(exercises);
		}

		emit exercisesChanged(exercises);
	}

	Q_INVOKABLE QVariantList getExercises() const {
		return m_workout ? m_workout.getExercises() : QVariantList();
	}

	Q_INVOKABLE void setDuration(int duration) const {
		if (m_workout) {
			m_workout.setDuration(duration);
			emit durationChanged(duration);
		}
	}

	Q_INVOKABLE int getDuration() const {
		return m_workout ? m_workout.getDuration() : -1;
	}

	Q_INVOKABLE void setInterval(int interval) const {
		if (m_workout) {
			m_workout.setInterval(interval);
			emit intervalChanged(interval);
		}
	}

	Q_INVOKABLE int getInterval() const {
		return m_workout ? m_workout.getInterval() : -1;
	}

	Q_INVOKABLE void setCooldown(int cooldown) const {
		if (m_workout) {
			m_workout.setCooldown(cooldown);
			emit cooldownChanged(cooldown);
		}
	}

	Q_INVOKABLE int getCooldown() const {
		return m_workout ? m_workout.getCooldown() : -1;
	}

	Q_INVOKABLE bool start();
	Q_INVOKABLE bool pause();
	Q_INVOKABLE bool resume();
	Q_INVOKABLE bool stop();

signals:
	void exercisesChanged(QVariantList newList);
	void durationChanged(int newDuration);
	void intervalChanged(int newInterval);
	void cooldownChanged(int newCooldown);

	void started();
	void paused();
	void resumed();
	void stopped();
	void exerciseStarted(QVariant exercise);
	void exerciseComplete(QVariant exercise);

private:
	Workout m_workout;
	int m_current_exercise;
};

class Workout {
public:
	Workout(QVariantList exercises, int duration = 30, int interval = 15, int cooldown = 120);
	~Workout();

	int getCooldown() const {
		return m_cooldown;
	}

	void setCooldown(int cooldown) {
		m_cooldown = cooldown;
	}

	int getDuration() const {
		return m_duration;
	}

	void setDuration(int duration) {
		m_duration = duration;
	}

	const QVariantList& getExercises() const {
		return m_exercises;
	}

	void setExercises(const QVariantList& exercises) {
		m_exercises = exercises;
	}

	int getInterval() const {
		return m_interval;
	}

	void setInterval(int interval) {
		m_interval = interval;
	}

private:
	QVariantList m_exercises;
	int m_duration;
	int m_interval;
	int m_cooldown;
};

#endif /* WORKOUTTRACKER_HPP_ */
