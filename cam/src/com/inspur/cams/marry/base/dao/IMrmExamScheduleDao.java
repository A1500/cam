package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmExamSchedule;

/**
 * @title:IMrmExamScheduleDao
 * @description:
 * @author:
 * @since:2011-12-05
 * @version:1.0
*/
 public interface IMrmExamScheduleDao extends BaseCURD<MrmExamSchedule>{
	public void save(List<MrmExamSchedule> list);
}

