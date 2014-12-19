package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmPosition;

/**
 * @title:IMrmPositionDao
 * @description:
 * @author:
 * @since:2011-12-06
 * @version:1.0
*/
 public interface IMrmPositionDao extends BaseCURD<MrmPosition>{
	public void save(List<MrmPosition> list);
}

