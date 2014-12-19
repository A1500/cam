package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamApplyOptionsHis;

/**
 * @title:申请审批历史意见Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
*/
 public interface ISamApplyOptionsHisDao extends BaseCURD<SamApplyOptionsHis>{
	public void save(List<SamApplyOptionsHis> list);
}

