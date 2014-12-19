package com.inspur.cams.bpt.regulations.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.regulations.dao.BptRegulationsAttachmentDao;

public class BptRegulationsAttachmentQueryCmd extends BaseQueryCommand{
    private BptRegulationsAttachmentDao dao = (BptRegulationsAttachmentDao) DaoFactory.getDao(BptRegulationsAttachmentDao.class);
	
    public DataSet execute(){
		String id=(String)getParameter("id");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("REGULATIONS_ID",id);
		DataSet ds = dao.query(pset);
		return ds;
	}
}
