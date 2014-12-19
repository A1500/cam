package com.inspur.cams.comm.comphoto.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.comphoto.dao.IComPhotoDao;
import com.inspur.cams.comm.comphoto.data.ComPhoto;

public class ComPhotoDomain implements IComPhotoDomain{
	
	@Reference
	private IComPhotoDao comPhotoDao ;

	public DataSet query(ParameterSet parameterSet) {
		return getComPhotoDao().query(parameterSet);
	}

	public void save(List<ComPhoto> list) {
		getComPhotoDao().save(list);
	}

	public ComPhoto update(ComPhoto comPhoto) {
		return getComPhotoDao().updateWithFile(comPhoto);
		
	}

	public void batchUpdate(List<ComPhoto> list) {
		getComPhotoDao().batchUpdateWithFile(list);
		
	}
	
	public ComPhoto insertPhoto(ComPhoto comPhoto){
		return getComPhotoDao().insertPhoto(comPhoto);
	}

	/**
	 * @param comPhotoDao the comPhotoDao to set
	 */
	public void setComPhotoDao(IComPhotoDao comPhotoDao) {
		this.comPhotoDao = comPhotoDao;
	}

	/**
	 * @return the comPhotoDao
	 */
	public IComPhotoDao getComPhotoDao() {
		return comPhotoDao;
	}

}
