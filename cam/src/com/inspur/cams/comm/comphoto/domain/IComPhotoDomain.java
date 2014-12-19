package com.inspur.cams.comm.comphoto.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.comphoto.data.ComPhoto;

public interface IComPhotoDomain {
	
	public DataSet query(ParameterSet parameterSet);
	
	public void save(List<ComPhoto> list);
	
	public ComPhoto update(ComPhoto comPhoto);
	
	public void batchUpdate(List<ComPhoto> list);
	
	public ComPhoto insertPhoto(ComPhoto comPhoto);
}
