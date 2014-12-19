package com.inspur.cams.bpt.regulations.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.regulations.data.BptRegulations;

 public interface IBptRegulationsDao extends BaseCURD<BptRegulations>{
	public void save(List<BptRegulations> list);
}

