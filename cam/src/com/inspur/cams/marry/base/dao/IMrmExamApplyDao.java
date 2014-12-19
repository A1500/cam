package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IMrmExamApplyDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public interface IMrmExamApplyDao extends BaseCURD<MrmExamApply>{
	public void save(List<MrmExamApply> list);
}

