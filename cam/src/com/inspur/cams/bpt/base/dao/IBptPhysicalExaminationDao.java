package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.base.data.BptPhysicalExamination;

/**
 * @title:IBptPhysicalExaminationDao
 * @description:
 * @author:
 * @since:2011-12-27
 * @version:1.0
*/
 public interface IBptPhysicalExaminationDao extends BaseCURD<BptPhysicalExamination>{
	public void save(List<BptPhysicalExamination> list);
}

