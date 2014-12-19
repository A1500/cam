package com.inspur.cams.bpt.regulations.dao;

import java.util.List;
import java.util.Map;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.regulations.data.BptRegulationsAttachment;

 public interface IBptRegulationsAttachmentDao extends BaseCURD<BptRegulationsAttachment>{
	public void save(List<BptRegulationsAttachment> list);
	
	public void batchDeleteByRegulationId(String[] delIds);
	
	public List<Map<String,Object>> queryByRegulationId(String policiesRegId);
	/**
	 * 附件下载
	 * @param id
	 * @param filename
	 * @return
	 */
	public List<Map<String,Object>> download(String id,String filename);
	
	//删除附件记录
	public void deleteUploadFile(ParameterSet pset);
}

