package com.inspur.cams.dis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.dis.base.data.DisBaseFamilyRecord;

/**
 * @title:IDisBaseFamilyRecordDao
 * @description:
 * @author:
 * @since:2012-10-23
 * @version:1.0
*/
 public interface IDisBaseFamilyRecordDao extends BaseCURD<DisBaseFamilyRecord>{
	public void save(List<DisBaseFamilyRecord> list);
}

