package com.inspur.cams.bpt.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.bpt.base.dao.jdbc.BptYearPhotoDao;
import com.inspur.cams.bpt.base.data.BptYearPhoto;
import com.inspur.cams.comm.util.PhotoUtil;

/**
 * BptYearPhotoQueryCommand
 * @description:
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
public class BptYearPhotoCommand extends BaseAjaxCommand{
	private BptYearPhotoDao dao = (BptYearPhotoDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptYearPhotoDao");
	
	
	@Trans
	public void insertYearPhoto() {
		String photoTemp = (String) getParameter("photoTemp");
		String peopleId = (String) getParameter("peopleId");
		String year = (String) getParameter("year");
		String photoId="";
		BptYearPhoto dataBean= new BptYearPhoto();
		dataBean.setPeopleId(peopleId);
		
		if (null != photoTemp && !"".equals(photoTemp)) {
			photoId = PhotoUtil.savePhoto(photoTemp);
		}

		if (photoId != null && !"".equals(photoId)) {
			dataBean.setPhotoId(photoId);
		}
		if (year != null && !"".equals(year)) {
			dataBean.setYear(year);
		}
		ParameterSet pst = new ParameterSet();
		pst.setParameter("people_Id",peopleId);
		pst.setParameter("year",year);
		DataSet ds = dao.query(pst);
		if(ds.getCount()>0){
			BptYearPhoto byp=(BptYearPhoto)ds.getRecord(0).toBean(BptYearPhoto.class);
			dao.deleteYearPhoto(byp.getPhotoId());
			dao.insert(dataBean);
		}else{
			dao.insert(dataBean);
		}
		
	}
	@Trans
	public void deleteYearPhoto(){
		String photoId = (String) getParameter("photoId");
		dao.deleteYearPhoto(photoId);
	}
	public DataSet getYearPhotosByPeopleId(String peopleId) {
		BptYearPhotoDao yeardao = (BptYearPhotoDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptYearPhotoDao");
		ParameterSet pst = new ParameterSet();
		List list = new ArrayList();
		pst.setParameter("people_Id", peopleId);
		pst.setSortField("year");
		pst.setSortDir("desc");
		DataSet ds =yeardao.query(pst);
		/*for (int i = 0; i < ds.getCount(); i++) {
			list.add(ds.getRecord(i).get("photoId"));
		}*/
		return ds;
	}
}
